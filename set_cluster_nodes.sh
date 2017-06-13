#/bin/bash

set -e
set -u

function join_by { local IFS="$1"; shift; echo "$*"; }
sleep 5
STATEFUL_SETS=$(curl -f -k localhost:8001/apis/apps/v1beta1/namespaces/default/statefulsets)
RMQ_SS=$(echo $STATEFUL_SETS | jq '.items[] | select(.metadata.name == "rabbitmq")')
REPLICAS=$(echo $RMQ_SS | jq .spec.replicas)
SERVICE_NAME=$(echo $RMQ_SS | jq .spec.serviceName | tr -d '"')
(( REPLICAS-= 1 ))
NODES=()

for i in $(seq 0 $REPLICAS)
do
  NODES+=("{'rabbit@rabbitmq-$i', disc}")
done

JOINED=$(join_by , "${NODES[@]}")

sed -i "s/@@RABBITMQ_NODES@@/$JOINED/g" /etc/rabbitmq/clusterer.config
sed -i "s/@@RABBITMQ_GOSPEL_NODE@@/'rabbit@rabbitmq-0'/g" /etc/rabbitmq/clusterer.config
