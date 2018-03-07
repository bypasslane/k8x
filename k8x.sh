#!/usr/bin/env bash

# get kube context and namespace

# mkdir for context
# mksubDir for namespace
# export all deployments, configmaps, services, SERVICE

CONTEXT_NAME="$(kubectl config current-context)"
CONTEXT_DIR="$CONTEXT_NAME.$(date +%Y-%m-%d-%H%m.%S)"

mkdir ${CONTEXT_DIR}
cd ${CONTEXT_DIR}

kubectl get namespace | awk -F " " '{print $1}' | tail -n+2 | while read NAMESPACE; do
    echo "Namespace: ${NAMESPACE}"
    mkdir ${NAMESPACE}
    cd ${NAMESPACE}
    echo -e "\t Deployments:"
    kubectl get deployment --namespace=${NAMESPACE} | awk -F " " '{print $1}' | tail -n+2 | while read DEPLOYMENT; do
        if ! [[ ${DEPLOYMENT} =~  "No resources found." ]]; then
            echo -e "\t\t${DEPLOYMENT}.deployment.yaml"
            kubectl get deployment ${DEPLOYMENT} --namespace=${NAMESPACE} -oyaml --export=true > ${DEPLOYMENT}.deployment.yaml &
        fi
    done
    wait
    echo -e "\t Configmaps:"
    kubectl get configmap --namespace=${NAMESPACE} | awk -F " " '{print $1}' | tail -n+2 | while read CONFIG_MAP; do
        if ! [[ ${CONFIG_MAP} =~  "No resources found." ]]; then
            echo -e "\t\t${CONFIG_MAP}.configmap.yaml"
            kubectl get configmap ${CONFIG_MAP} --namespace=${NAMESPACE} -oyaml --export=true > ${CONFIG_MAP}.configmap.yaml &
        fi
    done
    wait
    echo -e "\t Services:"
    kubectl get service --namespace=${NAMESPACE} | awk -F " " '{print $1}' | tail -n+2 | while read SERVICE; do
        if ! [[ ${SERVICE} =~  "No resources found." ]]; then
            echo -e "\t\t${SERVICE}.service.yaml"
            kubectl get service ${SERVICE} --namespace=${NAMESPACE} -oyaml --export=true > ${SERVICE}.service.yaml &
        fi
    done
    wait
    echo -e "\t Ingresses:"
    kubectl get ingress --namespace=${NAMESPACE} | awk -F " " '{print $1}' | tail -n+2 | while read INGRESS; do
        if ! [[ ${INGRESS} =~  "No resources found." ]]; then
            echo -e "\t\t${INGRESS}.ingress.yaml"
            kubectl get ingress ${INGRESS} --namespace=${NAMESPACE} -oyaml --export=true > ${INGRESS}.ingress.yaml &
        fi
    done
    wait
    cd ..
done

echo ${CONTEXT_DIR}
