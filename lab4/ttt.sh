#!/bin/bash
# Shell Script for Monitoring Memory Usage with Alerts
# Usage: ./memory_monitor.sh
# Function to display memory usage
display_memory_usage() {
  echo "Current Memory Usage:"
  free -h
  echo ""
}

# Function to display memory usage in real-time
monitor_memory_usage() {
  echo "Monitoring memory usage in real-time. Press [CTRL+C] to stop."
  # Use top command to show memory usage updates every 2 seconds
  top -o %MEM
}

# Function to check and alert on memory usage
check_memory_usage() {
  local threshold=90 # Percentage threshold for alert
  local used_percent=$(free | awk 'NR==2{printf "%.2f", $3*100/$2}')

  if (( $(echo "$used_percent > $threshold" | bc -l) )); then
    echo "ALERT: Memory usage is above $threshold% ($used_percent%)!"
    # Add your alert mechanism here (e.g., send an email, log to a file, etc.)
    # Example: send an email (requires mail command to be configured)
    # echo "Memory usage is high ($used_percent%)!" | mail -s "Memory Alert" your_email@example.com
    # Example: log to a file
    echo "$(date): Memory usage is high ($used_percent%)!" >> memory_alerts.log
  fi
}

# Displaying options to the user
echo "Dynamic Memory Monitor with Alerts"
echo "1. Display current memory usage"
echo "2. Monitor memory usage in real-time"
echo "3. Monitor memory usage and alert (every 5 seconds)"
echo "4. Exit"

# Loop until the user chooses to exit
while true; do
  read -p "Select an option (1-4): " option
  case $option in
    1) # Display current memory usage
      display_memory_usage
      ;;
    2) # Monitor memory usage in real-time
      monitor_memory_usage
      ;;
    3) # Monitor memory usage and alert
      echo "Monitoring memory usage and alerting every 5 seconds. Press [CTRL+C] to stop."
      while true; do
        check_memory_usage
        sleep 5
      done
      ;;
    4) # Exit the script
      echo "Exiting the memory monitor. Goodbye!"
      exit 0
      ;;
    *) # Invalid option
      echo "Invalid option. Please select 1-4."
      ;;
  esac
  echo "" # Print a newline for better readability
done
