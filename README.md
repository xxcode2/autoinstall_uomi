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
```bash
git clone https://github.com/xxcode2/autoinstall_uomi.git
cd autoinstall_uomi
Ubah permission dan jalankan script:
chmod +x autoinstall_uomi.sh
./autoinstall_uomi.sh
Masukkan nama node ketika ditanya:
Masukkan nama node anda: My-Uomi-Node
🔍 Perintah Penting

Cek status node

sudo systemctl status uomi.service --no-pager


Cek logs realtime

journalctl -fu uomi.service


Restart node

sudo systemctl restart uomi.service


Stop node

sudo systemctl stop uomi.service && sudo systemctl disable uomi.service


Backup data node

sudo tar -czf uomi-backup-$(date +%Y%m%d).tar.gz /var/lib/uomi

🌐 Verifikasi RPC Endpoint

Cek RPC dengan:

curl -H "Content-Type: application/json" \
  -d '{"id":1, "jsonrpc":"2.0", "method": "system_health", "params":[]}' \
  http://localhost:9944

📖 Dokumentasi Resmi
https://docs.uomi.ai/build/run-a-node/run-an-archive-node/binary
