#!/bin/bash

echo "Server Performance Stats"
echo "========================="

# CPU Usage
echo -e "\\nCPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\\([0-9.]*\\)%* id.*/\\1/" | awk '{print 100 - $1"%"}'

# Memory Usage
echo -e "\\nMemory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB\\n", $3, $3*100/$2, $4}'

# Disk Usage
echo -e "\\nDisk Usage:"
df -h / | awk 'NR==2{printf "Used: %s, Free: %s (%s)\\n", $3, $4, $5}'

# Top 5 Processes by CPU
echo -e "\\nTop 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6

# Top 5 Processes by Memory
echo -e "\\nTop 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -n 6

# Optional Stats
echo -e "\\nOS Version:"
cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f 2

echo -e "\\nUptime:"
uptime -p

echo -e "\\nLoad Average:"
cat /proc/loadavg

echo -e "\\nLogged-in Users:"
who

echo -e "\\nFailed Login Attempts:"
sudo lastb | head -n 

