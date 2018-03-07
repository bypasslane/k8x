#!/usr/bin/env bash

# get kube context and namespace

# mkdir for context
# mksubDir for namespace
# export all deployments, configmaps, services, injests

CONTEXT_NAME="$(kubectl config current-context)"

#NAMESPACES=$(kubectl get namespace | awk -F " " '{print $1}' | tail -n+2)
CONTEXT_DIR="$CONTEXT_NAME.$(date +%Y-%m-%d-%H%m.%S)"

mkdir ${CONTEXT_DIR}
cd ${CONTEXT_DIR}

kubectl get namespace | awk -F " " '{print $1}' | tail -n+2 | while read NAMESPACE; do
    echo "Namespace: ${NAMESPACE}"
    mkdir ${NAMESPACE}
    cd ${NAMESPACE}
    kubectl get deployment --namespace=${NAMESPACE} | awk -F " " '{print $1}' | tail -n+2 | while read DEPLOYMENT; do
        echo -e "\t${NAMESPACE}.${DEPLOYMENT}"
        kubectl get deployment ${DEPLOYMENT} --namespace=${NAMESPACE} -oyaml --export=true > ${DEPLOYMENT}.deployment.yaml
    done
    cd ..
done

echo ${CONTEXT_DIR}
