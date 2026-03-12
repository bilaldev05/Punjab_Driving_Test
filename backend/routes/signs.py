from fastapi import APIRouter
from database import db

router = APIRouter(prefix="/signs", tags=["Traffic Signs"])


@router.get("/")
def get_signs():

    signs = list(db.traffic_signs.find({}, {"_id": 0}))

    return signs