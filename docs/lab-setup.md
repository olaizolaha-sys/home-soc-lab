# Home SOC Lab Setup

## Overview

This home lab was created to practice cybersecurity monitoring and investigation in a controlled enviroment. The lab uses two Linux virtual machines connected through a private VirtualBox network. Kali Linux is used as the testing and analyst machine, while Ubuntu is used as the monitored system.

The goal of this lab is to practice identifying network activity, reviewing authentication and system logs, investigating suspicious behavior, and working with defensive tools in an enviroment where activity can be safely generated and analyzed.

## Lab Architecture 

The lab consists of two virtual machines running in VirtualBox:

- **Kali Linux** - Testing and analyst machine
  - Host-only IP: 192.168.56.103
  - Used to generate controlled network and SSH activity
  - Used for tools such as Nmap and other security testing utilities

- **Ubuntu Linux** - Monitored system
  - Hostname: ubuntu-lab
  - Host-only IP: 192.168.56.104
  - Runs the SSH service
  - Generates authentication and system logs for investigation
  - Uses Fail2ban and nftables as defensive controls

## Network Configuration

The Kali and Ubuntu virtual machines are connected using a VirtualBox host-only network. This allows the two systems to communicate with each other in an isolated lab environment without exposing the testing traffic directly to the outside network.

Kali uses the host-only address 192.168.56.103, and Ubuntu uses 192.168.56.104. Connectivity between the systems was verified using ping before additional services and security testing were configured.

The private network allows controlled activity to be generated from Kali and then investigated from the Ubuntu system.
