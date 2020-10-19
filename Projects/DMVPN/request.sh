#!/bin/bash


curl -X POST -H "Content-Type: application/json" -d "$(sudo cat ~/Documents/Git/Kubernetes/Projects/DMVPN/testbody.json)" localhost:5000/api/config/
