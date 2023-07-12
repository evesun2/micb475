#!/bin/bash

# Module 2

# connecting to the server
ssh <username>@<server address>

##If it is your first time connecting to this server you will likely get the following warning: 
##REMOTE HOST IDENTIFICATION HAS CHANGED!

#To get around this issue, use the following command:

ssh-keygen -R <IP address> 

##Then re-attempt to connect again and you will get the following message:

##The authenticity of host '<server address>' can't be established.
##ECDSA key fingerprint is <SHA256 number>.
##Are you sure you want to continue connecting (yes/no/[fingerprint])?
##Enter yes and, when prompted, provide your password.

#Your terminal should read something like this.

<username>@<server name> ~ #

# transfer files to your local computer
scp <username>@<server address>:<remote source> <local target>

# transfer files to the server
scp <local source> <username>@<server address>:<remote target>

# running jobs in the background, create a detached screen
screen -S <session name>

# When you log back into the server, you can confirm that the session is still running by listing all screen sessions with
screen -ls

#If you want to resume a session, you use
screen -r <session name>