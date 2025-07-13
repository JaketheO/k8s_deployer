docker build -t k8s-deployer k8s_deployer/
kind create cluster --config=cluster-config.yml
kind load docker-image k8s-deployer
kubectl apply -f all-in-one.yml
sleep 10
response=$(curl -X POST http://localhost:8000/deploy   -H "Content-Type: application/json"   -d '{"image": "$1"}')
echo $response
deployment_name=$(echo "$response" | grep -oP '"deployment_name"\s*:\s*"\K[^"]+')
curl -X GET http://localhost:8000/status/$deployment_name

kind delete clusters kind