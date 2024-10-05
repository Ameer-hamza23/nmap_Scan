#!/bin/bash

# Display scan options
echo "Please select an option"
echo "1) Regular Scan"
echo "2) Quick Trace Route"
echo "3) Quick Scan"
echo "4) Quick Scan Plus"
echo "5) Ping Scan"

# Read user selection and target IP
read -p "Select an option: " OPT
read -p "Enter Target IP: " IP

# Check if IP is empty
if [[ -z "$IP" ]]; then
  echo "Please enter an IP address."
  exit 1
fi

# Perform a ping test before any scan
ping -c 5 $IP

# Check if the ping was successful
if [[ $? -eq 0 ]]; then
  echo "Ping successful. Starting scan..."
else
  echo "Ping failed. Exiting."
  exit 1
fi

# Handle scan types based on user selection
case $OPT in
  1)
    echo "Performing Regular Scan with nmap..."
    nmap $IP
    ;;
  2)
    echo "Performing Quick Trace Route..."
    traceroute $IP
    ;;
  3)
    echo "Performing Quick Scan with nmap..."
    nmap -T4 -F $IP
    ;;
  4)
    echo "Performing Quick Scan Plus with nmap..."
    nmap -sV -T4 -O -F --version-light $IP
    ;;
  5)
    echo "Performing Ping Scan with nmap..."
    nmap -sn $IP
    ;;
  *)
    echo "Invalid option selected."
    exit 1
    ;;
esac
