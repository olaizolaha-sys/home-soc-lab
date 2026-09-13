# SSH Detection Scripts

## Overview

These scripts were created as part of my home SOC lab to practice detecting repeated SSH authentication failures and identifying potentially suspicious login activity.

## Bash Detector

File: `ssh-detector.sh`

This script reviews SSH authentication logs from `journalctl` and looks for failed password attempts within the last 30 minutes. It extracts the source IP addresses, counts how many failed attempts came from each IP, and generates an alert when an IP reaches the configured threshold.

### SOC Skills Practiced

- Linux log analysis
- Command-line filtering
- Threshold-based detection
- Bash automation

## Python Detector

File: `ssh_detector.py`

This script monitors SSH logs continuously using `journalctl`. When it detects a failed password event, it extracts the source IP address with a regular expression, tracks the number of failed attempts from that IP, and generates an alert when the threshold is reached.

### SOC Skills Practiced

- Python automation
- Real-time log monitoring
- Regular expressions
- Detection logic
