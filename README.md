# 🚀 Uomi Node Auto Installer  

Script ini membantu install dan menjalankan **Uomi Node** secara otomatis di server Ubuntu 22 / 24.  
Saat menjalankan script, kamu akan diminta untuk **mengisi nama node**, yang langsung digunakan dalam konfigurasi systemd.  

---

## 📋 Prasyarat  

- **Ubuntu 22.04** atau **Ubuntu 24.04**  
- Minimal **2 CPU, 4GB RAM, 80GB Disk** (lebih besar disarankan untuk archive node)  
- Akses root / sudo  

---

## ⚙️ Cara Install  

Clone repo ini:  
```
git clone https://github.com/xxcode2/autoinstall_uomi.git
cd autoinstall_uomi

Change permissions and run the script:
chmod +x autoinstall_uomi.sh
./autoinstall_uomi.sh
```
Enter the node name when asked:
```
Enter your node name: My-Uomi-Node
```
## 🔍 Important Commands
```
## 🔍 Important Commands
🔹 Check node status
sudo systemctl status uomi.service --no-pager```

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
