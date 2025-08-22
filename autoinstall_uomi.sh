#!/bin/bash
set -e

echo "=== Uomi Node Auto Installer ==="

# 1. Tanya nama node
read -p "Masukkan nama node anda: " NODE_NAME

# 2. Install dependencies
echo ">>> Install prerequisites..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt-get install -y curl jq build-essential libssl-dev pkg-config cmake git libclang-dev ufw

# 3. Firewall
sudo ufw allow ssh
sudo ufw allow 9944/tcp
sudo ufw allow 30333/tcp

# 4. User & dir
echo ">>> Setup user & directories..."
sudo useradd --no-create-home --shell /usr/sbin/nologin uomi || true
sudo mkdir -p /var/lib/uomi
sudo chown -R uomi:uomi /var/lib/uomi

# 5. Download binary + genesis
echo ">>> Downloading Uomi binary & genesis.json..."
cd $HOME && mkdir -p uomi && cd uomi
wget -O genesis.json https://github.com/Uomi-network/uomi-node/releases/latest/download/genesis.json

# Deteksi versi ubuntu
UBUNTU_VER=$(lsb_release -rs | cut -d. -f1)
if [ "$UBUNTU_VER" -eq "22" ]; then
  wget -O uomi https://github.com/Uomi-network/uomi-node/releases/latest/download/uomi_ubuntu_22
elif [ "$UBUNTU_VER" -eq "24" ]; then
  wget -O uomi https://github.com/Uomi-network/uomi-node/releases/latest/download/uomi_ubuntu_24
else
  echo "Ubuntu versi $UBUNTU_VER belum didukung. Gunakan 22 atau 24."
  exit 1
fi

chmod +x uomi
sudo cp ./uomi /usr/local/bin/
sudo chmod +x /usr/local/bin/uomi
sudo cp ./genesis.json /usr/local/bin/

# 6. Buat service file
echo ">>> Membuat systemd service..."
SERVICE_FILE=/etc/systemd/system/uomi.service
sudo tee $SERVICE_FILE > /dev/null <<EOF
[Unit]
Description=Uomi Node
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=uomi
Group=uomi
Restart=always
RestartSec=10
LimitNOFILE=65535
ExecStart=/usr/local/bin/uomi \\
  --name "$NODE_NAME" \\
  --chain "/usr/local/bin/genesis.json" \\
  --base-path "/var/lib/uomi" \\
  --pruning archive \\
  --rpc-cors all \\
  --rpc-external \\
  --rpc-methods Safe \\
  --enable-evm-rpc \\
  --prometheus-external \\
  --telemetry-url "wss://telemetry.polkadot.io/submit/ 0"

ProtectSystem=strict
PrivateTmp=true
PrivateDevices=true
NoNewPrivileges=true
ReadWritePaths=/var/lib/uomi

[Install]
WantedBy=multi-user.target
EOF

# 7. Enable & start
echo ">>> Menjalankan node..."
sudo systemctl daemon-reload
sudo systemctl enable uomi.service
sudo systemctl start uomi.service

echo "=== Instalasi selesai! ==="
echo "Cek status dengan: sudo systemctl status uomi.service --no-pager"
echo "Cek logs   dengan: journalctl -fu uomi.service"
