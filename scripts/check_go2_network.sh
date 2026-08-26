#!/usr/bin/env bash

set -e

GO2_IP="${UNITREE_GO2_IP:-192.168.123.161}"
CONTROLLER_IP="${UNITREE_CONTROLLER_IP:-192.168.123.18}"

echo "Checking Go2 network reachability"
echo "Go2 IP:        ${GO2_IP}"
echo "Controller IP: ${CONTROLLER_IP}"
echo ""

echo "Local interfaces:"
ip -br addr || true
echo ""

echo "Routing table:"
ip route || true
echo ""

echo "Pinging Go2..."
ping -c 4 "${GO2_IP}"
echo ""

echo "Pinging controller..."
ping -c 4 "${CONTROLLER_IP}"
echo ""

echo "Go2 network check complete."
