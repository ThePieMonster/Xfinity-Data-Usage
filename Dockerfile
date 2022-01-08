FROM ubuntu:focal

ARG TZ
ENV TZ=$TZ

# install openssh-server
RUN apt-get update
RUN apt-get install openssh-server -y

# install python and other tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3 python3.9 python3-pip \
    fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 \
    libnspr4 libnss3 lsb-release xdg-utils libxss1 libdbus-glib-1-2 \
    libgbm1 \
    curl unzip wget \
    xvfb

# fix different requests module installed by the OS and the python dependencies
RUN pip3 install requests --upgrade requests

# install geckodriver and firefox
RUN GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz

RUN FIREFOX_SETUP=firefox-setup.tar.bz2 && \
    apt-get purge firefox && \
    wget -O $FIREFOX_SETUP "https://download.mozilla.org/?product=firefox-latest&os=linux64" && \
    tar xjf $FIREFOX_SETUP -C /opt/ && \
    ln -s /opt/firefox/firefox /usr/bin/firefox && \
    rm $FIREFOX_SETUP

# install chromedriver and google-chrome
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/bin && \
    chmod +x /usr/bin/chromedriver && \
    rm chromedriver_linux64.zip

RUN CHROME_SETUP=google-chrome.deb && \
    wget -O $CHROME_SETUP "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" && \
    dpkg -i $CHROME_SETUP && \
    apt-get install -y -f && \
    rm $CHROME_SETUP

# install phantomjs
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar -jxf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
    rm phantomjs-2.1.1-linux-x86_64.tar.bz2

# install selenium
RUN pip3 install selenium
RUN pip3 install pyvirtualdisplay
RUN pip3 install Selenium-Screenshot
RUN pip3 install paho-mqtt

# install pip requirements for influx
RUN pip3 install influxdb
#RUN pip3 install influxdb-client

# Current copy needed deltas for firefox-headless
# Also changes to control attempt count at runtime
# Install source code
ADD xfinity-usage xfinity-usage
WORKDIR /xfinity-usage
RUN pip3 install -e .

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY run.py /app
COPY config.ini /app

#ENV APP_HOME /app/data
#WORKDIR /$APP_HOME
#COPY . $APP_HOME/

# Set entrypoint
# Only the last CMD command will run in a Dockerfile
#CMD tail -f /dev/null
CMD ["python3", "-u", "/app/run.py"]
