from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from k8s_utils import create_deployment, get_pod_status

app = FastAPI()

class DeployRequest(BaseModel):
    image: str

@app.post("/deploy")
def deploy_image(req: DeployRequest):
    try:
        deployment_name = create_deployment(req.image)
        return {"message": "Deployment started", "deployment_name": deployment_name}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/status/{deployment_name}")
def deployment_status(deployment_name: str):
    try:
        status = get_pod_status(deployment_name)
        return {"deployment": deployment_name, "pods": status}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
