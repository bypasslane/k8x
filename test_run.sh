#!/usr/bin/env bash

rm -rf helium* saturn*
kubectl config use-context saturn
./k8x.sh
kubectl config use-context helium
./k8x.sh
bcomp h* s*