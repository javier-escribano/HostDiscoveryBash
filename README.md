
# Host Discovery Bash Tool

## Installation

As it is a bash script, it does not require any further installation. You will only need to make the file executable for the user who is going to execute it.

## Comments

This is a Host Discovery tool, so the easiest way to know the accessibility of a machine is to ping it. If you receive a response package the machine is up, on the other hand it is down or it has some rules which are not allowing you to communicate with the machine.

If it is down, there is a timeout established of 1 second. So, as this tool has a range scan mode which makes a scan of all the class network, it will last 1 second for each INACCESSIBLE machine. 
