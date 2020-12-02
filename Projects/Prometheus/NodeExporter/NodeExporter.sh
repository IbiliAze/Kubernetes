#!/bin/bash



echo step 1
sudo apt update -y
sudo useradd -M -r -s /bin/false node_exporter

echo step 2
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz

echo step 3
tar xvfz node_exporter-1.0.1.linux-amd64.tar.gz

echo step 4
sudo cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin/

echo step 5
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo step 6
sudo echo '''[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target''' > node_exporter.service

echo step 7
sudo cp node_exporter.service /etc/systemd/system/node_exporter.service

echo step 8
sudo systemctl daemon-reload

echo step 9
sudo systemctl start node_exporter

echo step 10
sudo systemctl enable node_exporter

echo step 11
sudo systemctl status node_exporter

echo step 12
curl localhost:9100/metrics

