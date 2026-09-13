import subprocess
import re

failed_logins = {}
threshold = 3

process = subprocess.Popen(
    ["journalctl", "-u", "ssh", "-f"],
    stdout=subprocess.PIPE,
    text=True
)

for line in process.stdout:
    if "Failed password" in line:
        match = re.search(r'(\d{1,3}\.){3}\d{1,3}', line)

        if match:
            ip = match.group()

            if ip in failed_logins:
                failed_logins[ip] += 1
            else:
                failed_logins[ip] = 1

            print(f"[FAILED LOGIN] {ip} - Attempts: {failed_logins[ip]}")

            if failed_logins[ip] >= threshold:
                print(f"[ALERT] Possibe SSH brute-force activity from {ip}")
