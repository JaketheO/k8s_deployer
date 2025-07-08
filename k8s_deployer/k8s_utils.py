from kubernetes import client, config
import uuid
import os

# Try in-cluster config first, fallback to local config
try:
    config.load_incluster_config()
except config.ConfigException:
    config.load_kube_config()

v1 = client.CoreV1Api()
apps_v1 = client.AppsV1Api()

def create_deployment(image_name: str) -> str:
    deployment_name = f"deploy-{uuid.uuid4().hex[:6]}"
    container = client.V1Container(
        name="app-container",
        image=image_name,
        ports=[client.V1ContainerPort(container_port=80)]
    )
    template = client.V1PodTemplateSpec(
        metadata=client.V1ObjectMeta(labels={"app": deployment_name}),
        spec=client.V1PodSpec(containers=[container])
    )
    spec = client.V1DeploymentSpec(
        replicas=1,
        selector=client.V1LabelSelector(match_labels={"app": deployment_name}),
        template=template
    )
    deployment = client.V1Deployment(
        metadata=client.V1ObjectMeta(name=deployment_name),
        spec=spec
    )
    apps_v1.create_namespaced_deployment(namespace="default", body=deployment)
    return deployment_name

def get_pod_status(deployment_name: str) -> list:
    label_selector = f"app={deployment_name}"
    pods = v1.list_namespaced_pod(namespace="default", label_selector=label_selector)
    return [
        {
            "name": pod.metadata.name,
            "phase": pod.status.phase,
            "hostIP": pod.status.host_ip,
            "podIP": pod.status.pod_ip
        }
        for pod in pods.items
    ]
