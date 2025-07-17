
# Load the env variables (.env needs to be created, it's not in the Github repo)
source .env

# Install Helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Create the monitoring namespace
kubectl create namespace monitoring

# Create the tls secret that contains the server cert and key
kubectl create secret tls tls-cert \
  --cert=$CRT_FILE_PATH --key=$KEY_FILE_PATH \
  -n monitoring

# Install or upgrade the kube prometheus stack
# Set the GRAFANA_HOSTNAME env variable to your Grafana hostname
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  -f grafana-values.yaml \
  --set "grafana.ingress.hosts[0]=$GRAFANA_HOSTNAME" \
  --set "grafana.ingress.tls[0].hosts[0]=$GRAFANA_HOSTNAME"

# Install the Microservices Runtime dashboard in Grafana (it automatically wires to the default Prometheus datasource)
# The yaml manifest references the monitoring namespace
kubectl apply -f msr-dashboard.yaml

# Deploy a generic Service Monitor that points to all the services within the integration namespace, having the "monitoring: enabled" label
# The yaml manifest references the monitoring namespace
kubectl apply -f servicemonitor.yaml

# Display the Grafana password (user name is "admin")
kubectl --namespace monitoring get secrets kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

# Install Jaeger all in one
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo update

helm upgrade --install jaeger jaegertracing/jaeger \
  --namespace monitoring \
  --set allInOne.enabled=true \
  --set collector.enabled=false \
  --set agent.enabled=false \
  --set query.enabled=false \
  --set storage.type=memory \
  --set provisionDataStore.cassandra=false \
  --set provisionDataStore.elasticsearch=false \
  --set provisionDataStore.kafka=false


kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jaeger
  namespace: monitoring
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - jaeger.sttlab.local
      secretName: tls-cert
  rules:
    - host: jaeger.sttlab.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: jaeger-query
                port:
                  number: 16686
EOF


