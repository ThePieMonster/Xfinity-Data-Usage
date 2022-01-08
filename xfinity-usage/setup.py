from setuptools import setup, find_packages
from xfinity_usage.version import VERSION, PROJECT_URL

with open('README.rst', encoding="utf-8") as file:
    long_description = file.read()

requires = [
    'selenium'
]

classifiers = [
    'Development Status :: 5 - Production/Stable',
    'Environment :: Console',
    'Intended Audience :: End Users/Desktop',
    'License :: OSI Approved :: GNU Affero General Public License v3 or '
    'later (AGPLv3+)',
    'Natural Language :: English',
    'Operating System :: OS Independent',
    'Programming Language :: Python',
    'Programming Language :: Python :: 2.7',
    'Programming Language :: Python :: 3',
    'Topic :: Home Automation',
    'Topic :: Internet',
    'Topic :: System :: Monitoring',
    'Topic :: System :: Networking :: Monitoring',
]

setup(
    name='xfinity-usage',
    version=VERSION,
    author='Jason Antman',
    author_email='jason@jasonantman.com',
    packages=find_packages(),
    url=PROJECT_URL,
    description='Python/selenium script to get Xfinity bandwidth usage from '
                'Xfinity MyAccount website.',
    long_description=long_description,
    install_requires=requires,
    keywords="comcast xfinity usage data meter bandwidth",
    classifiers=classifiers,
    entry_points="""
    [console_scripts]
    xfinity-usage = xfinity_usage.xfinity_usage:main
    """
)
