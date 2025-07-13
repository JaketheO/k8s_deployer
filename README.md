# Antworten

Solutions for the Application-Task as a Senior DevOps Engineer.

## Part 1

Build a new Docker Image with the Application written in the directory 'k8s_deployer'.
```
docker build -t k8s-deployer k8s_deployer/
```
Start a new kind cluster for local tests.
```
kind create cluster --config=cluster-config.yml
```
Load the custom docker image into the kind cluster.
```
kind load docker-image k8s-deployer
```
Apply the 'all-in-one.yml' Manifest.
```
kubectl apply -f all-in-one.yml
```

Test the Deployment
```
curl -X POST http://localhost:8000/deploy   -H "Content-Type: application/json"   -d '{"image": "<DOCKER_IMAGE>"}'
```
Test Status
```
curl -X GET http://localhost:8000/status/<DEPLOYMENT_NAME>
```



Or start a quick test.
```
test.sh
```

## Part 2

### Question 1

- Prevent Public access to this api to protect valuable compute ressources.
- Prevent arbitrary Image deployment with a custom docker registry or by adding a whitelist of allowed docker images to the deployment microservice.
- Restrict the Network access to the api and isolate workloads.
- Set Ressource Quotas to ensure stable operation.
- Encrypt secrets and rotate them regularly.

### Question 2

- Are sufficient ressources allocated to the kubernetes cluster? (CPU, Memory)
- Add a scaling option for the deployment api + queue incomming api requests.
- How is the Cleanup done?
- How to manage the network access of the pods?
- Do we offer persistent storage? How do we manage persistent storage?
- Use a deployment for each new request, so pods can be redeployed and scaled, recieve persistent storage or an external IP/Port

### Question 3

- Add a graylog and prometheus instance to collect logs and metrics and visualize the results with grafana.
- Monitor the health of the pods by using the api /status endpoint.
- Implement Liveness and Readiness Probes.

