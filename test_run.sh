#!/usr/bin/env bash

rm -rf helium* saturn*
kubectl config set-context saturn
./k8x.sh
kubectl config set-context helium
./k8x.sh
bcomp h* s*