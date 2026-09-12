# SOC Investigation Startup Checklist

## Purpose

This checklist provides a repeatable process for beginning an investigation on a Linux system. The goal is to establish a baseline, identify suspicious activity, verify defensive controls, and document findings before making conclusions about the system.

## 1. Identify the System

Confirm the current user and hostname.

```bash
whoami
hostname

## 2. Review Network Configuration

ip a

## 3. Verify Connectivity

ping -c 3 <target-ip>

## 4. Enumerate Exposed Services

Scan the target system to identify open ports, services, and service versions.

```bash
nmap -sV <target-ip>

## 5. Review SSH Authentication Logs

Review SSH service logs for successful logins, failed authentication attempts, and unusual source IP addresses.

```bash
sudo journalctl -u ssh

## 6. Narrow the Investigation Timeline

Review recent SSH activity within a specific time window to focus the investigation on relevant events.

```bash
sudo journalctl -u ssh --since "-30 min" --no-pager

## 7. Filter for Suspicious Indicators

Filter recent authentication logs for a specific IP address or other indicator identified during the investigation.

```bash
sudo journalctl -u ssh --since "-30 min" --no-pager | grep "<target-ip>"


## 8. Inspect Running Processes

Review running processes for unexpected programs, unusual user activity, or processes that may correlate with other evidence.

```bash
ps aux

## 9. Review User Accounts

Identify users currently logged into the system and review local user accounts for unexpected or unfamiliar accounts.

```bash
who
cat /etc/passwd

## 10. Verify Fail2ban

Check the overall Fail2ban status and inspect the SSH jail for failed authentication attempts and banned IP addresses.

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd

## 11. Verify nftables Firewall Rules

Review the active nftables ruleset to verify firewall configuration and network enforcement.

```bash
sudo nft list ruleset

## 12. Initial Analyst Assessment

After completing the initial checks, review the collected evidence and classify findings as expected, noteworthy, or suspicious.

Consider:

- Are the IP addresses and logged-in users expected?
- Are unfamiliar accounts present?
- Are unexpected services or ports exposed?
- Do authentication logs show unusual failures or successful logins?
- Are unexpected processes running?
- Are Fail2ban and nftables functioning as expected?
- Do multiple findings correlate with each other?

Avoid declaring a system compromised based on a single unusual event. Conclusions should be based on evidence collected from multiple sources when possible.
