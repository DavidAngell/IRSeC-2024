# CLOUD

| OS           | IP           | Hostname  | Service | Service Port    | Assigned To |
| ------------ | ------------ | --------- | ------- | --------------- | ----------- |
| FreeBSD      | 192.168.17.1 | spy       | MySQL   | 3306            | Noah        |
| Ubuntu 22.04 | 192.168.17.2 | satelite  | Grafana | 3000?           | Bruno       |
| Win. Server  | 192.168.17.3 | submarine | SMB     | 445 (maybe 139) | Luke        |
| Windows 10   | 192.168.17.4 | diplomat  | IIS     | 80?             | David       |


# LAN

| OS             | IP          | Hostname    | Service       | Service Port         | Assigned To |
| -------------- | ----------- | ----------- | ------------- | -------------------- | ----------- |
| Windows 10     | 10.17.1.1   | warhead     | WinRM         | 5985/5986            | Bruno       |
| Windows 10     | 10.17.1.2   | radar       | ICMP          | N/A                  | Noah        |
| WinServer 2022 | 10.17.1.3   | big brother | AD/DNS        |                      | David       |
| Ubuntu 22.04   | 10.17.1.4   | propaganda  | Docker (HTTP) | 80?                  | Max         |
| Rocky 9        | 10.17.1.5   | wiretap     | IMAP/SMTP     | 143/993/25?/465?/587 | Max         |
| Debian 12      | 10.17.1.6   | vault       | FTP           | 21/22                | Max         |
| pfSense        | 10.17.1.254 | ironcurtain |               |                      | Luke        |

# Out of Scope
- 172.16.1.0/24
- 172.29.2.0/23
- *.irsec.club
- *.ritsec.cloud
- Any DataDog agent processes, DataDog users, (dd-agent) and any IP located here: https://ip-ranges.us5.datadoghq.com/
- Files located in the /etc/datadog-agent, C:\ProgramData\Datadog, and C:\Program Files\Datadog\ directories 2. Users with datadog or dd-dog