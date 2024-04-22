#!/bin/bash

# Get the current date and time
current_time=$(TZ="Europe/Berlin" date +"%Y-%m-%d %H:%M:%S")

# Get the server's uptime
server_uptime=$(uptime)

# Log the server's uptime along with the current date and time
echo "Server Uptime - ${current_time}: ${server_uptime}" >> /var/log/uptime.log

