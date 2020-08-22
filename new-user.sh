#!/bin/bash

######################################################
# CONFIGURATION
######################################################

read -p "Enter Username" NEW_ACCOUNT_USERNAME
read -p "Enter Password" NEW_ACCOUNT_PASSWORD

######################################################
# Main Script - Do not modify
######################################################

# Add alternative user, add user to group "sudo", grant permissions
## Note: "useradd" is nearly identical to "adduser" => adduser should be used in cmd line
## but is not used in the script
useradd --create-home --groups sudo "${NEW_ACCOUNT_USERNAME}"
echo "${NEW_ACCOUNT_USERNAME}":"${NEW_ACCOUNT_PASSWORD}" | chpasswd

#If you have a problem with password (sudo), you can reset it in root: pkexec passwd $USER

# Add exception for SSH and then enable UFW firewall
ufw allow OpenSSH
ufw --force enable

#IF YOU ARE USING SSH KEY AUTHENTICATION INSTEAD OF PASSWORD, NEED TO COPY ROOT's SSH KEY TO NEW USER
rsync --archive --chown="${NEW_ACCOUNT_USERNAME}":"${NEW_ACCOUNT_USERNAME}" ~/.ssh /home/"${NEW_ACCOUNT_USERNAME}"
