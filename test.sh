docker build -t k8s-deploy-service k8s_deployer/
kind create cluster --config=cluster-config.yml
kind load docker-image k8s-deployer
kubectl apply -f all-in-one.yml
curl -X POST http://localhost:8000/deploy   -H "Content-Type: application/json"   -d '{"image": "$1"}'
# todo get returened deployment name
# curl -X GET http://localhost:8000/status/$deployment_name
kind delete clusters kind