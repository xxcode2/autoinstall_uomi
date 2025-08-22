# 🚀 Uomi Node Auto Installer

This script helps you automatically install and run Uomi Node on an Ubuntu 22/24 server.
When running the script, you will be prompted to enter a node name, which is directly used in the systemd configuration.

---

## 📋 Prerequisites

- Ubuntu 22.04 or Ubuntu 24.04
- Minimum 2 CPUs, 4GB RAM, 80GB disk space (more is recommended for archive nodes)
- Root/sudo access

---

## ⚙️ How to Install

Clone this repo:
```
git clone https://github.com/xxcode2/autoinstall_uomi.git
cd autoinstall_uomi
```
Change permissions and run the script:
```
chmod +x autoinstall_uomi.sh
./autoinstall_uomi.sh
```

Enter the node name when asked:
```
Enter your node name: My-Uomi-Node
```
## 🔍 Important Commands
```
🔹 Check node status

sudo systemctl status uomi.service --no-pager

🔹 Check real-time logs
journalctl -fu uomi.service

🔹 Restart node

sudo systemctl restart uomi.service


🔹 Stop node

sudo systemctl stop uomi.service && sudo systemctl disable uomi.service

🔹 Backup data node

sudo tar -czf uomi-backup-$(date +%Y%m%d).tar.gz /var/lib/uomi

## 🌐 Verify RPC Endpoint

Check RPC with:
curl -H "Content-Type: application/json" \
  -d '{"id":1,"jsonrpc":"2.0","method":"system_health","params":[]}' \
  http://localhost:9944
```
## 📖 Official Documentation
https://docs.uomi.ai/build/run-a-node/run-an-archive-node/binary
