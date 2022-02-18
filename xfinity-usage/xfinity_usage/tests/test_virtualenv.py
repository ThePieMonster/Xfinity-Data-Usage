import os
import sys
import time
import subprocess

print("Python Path:")
print(sys.path)

print("uname -a:")
subprocess.run(["uname", "-a"])

print("pip -V:")
subprocess.run(["pip", "-V"])

print("sys.prefix:")
print(sys.prefix)

print("sys.base_prefix:")
print(sys.base_prefix)

print("sys.version:")  
print(sys.version)
# python3 -c "import sys; print('\n'.join(sys.path))"
# ls -ls /usr/bin/python*
# whereis python

print("")
print(f'Running in virtual env: {"VIRTUAL_ENV" in os.environ}') # this only works when the environment is activated by the activate shell script
print(f'Python Executable: {sys.executable}')
print(f'Python Version: {sys.version}')
print(f'Virtualenv: {os.getenv("VIRTUAL_ENV")}')
print("")

print("pip list:")
subprocess.run(["pip", "list"])

print("")
