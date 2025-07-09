docker build -t k8s-deploy-service k8s_deployer/
kind create cluster --config=cluster-config.yml
kind load docker-image k8s-deploy-service
kubectl apply -f all-in-one.yml
kubectl get pods
kubectl port-forward [POD_NAME] 8000:8000
curl -X POST http://localhost:8001/deploy   -H "Content-Type: application/json"   -d '{"image": "nginx"}'
{"detail":"(403)\nReason: Forbidden\nHTTP response headers: HTTPHeaderDict({'Audit-Id': '31e47bc0-5642-496f-b0f9-0200ac9db5ce', 'Cache-Control': 'no-cache, private', 'Content-Type': 'application/json', 'X-Content-Type-Options': 'nosniff', 'X-Kubernetes-Pf-Flowschema-Uid': '99e0d109-a7d0-41f3-86d5-491623d3c7dc', 'X-Kubernetes-Pf-Prioritylevel-Uid': '819fc006-8ff4-4d9a-b344-e652f4bc242d', 'Date': 'Tue, 08 Jul 2025 21:29:46 GMT', 'Content-Length': '329'})\nHTTP response body: {\"kind\":\"Status\",\"apiVersion\":\"v1\",\"metadata\":{},\"status\":\"Failure\",\"message\":\"deployments.apps is forbidden: User \\\"system:serviceaccount:default:default\\\" cannot create resource \\\"deployments\\\" in API group \\\"apps\\\" in the namespace \\\"default\\\"\",\"reason\":\"Forbidden\",\"details\":{\"group\":\"apps\",\"kind\":\"deployments\"},\"code\":403}\n\n"}