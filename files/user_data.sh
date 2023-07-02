#!/usr/bin/env bash

# Populate the distributed properties with the broker addresses
sed -i "s/\[KAFKA_BROKERS\]/${brokers}/g" /home/ubuntu/kafka/config/connect-distributed.properties

# Create the systemd service file
sudo mv /home/ubuntu/debezium.service /etc/systemd/system/debezium.service

# Reload the systemd daemon
sudo systemctl daemon-reload

# Enable the service on startup
sudo systemctl enable debezium

# Start services
sudo service debezium start