from fastapi import APIRouter
from database import db

router = APIRouter(prefix="/signs", tags=["Traffic Signs"])


@router.get("")
def get_signs():
    # Fetch all signs from MongoDB and exclude '_id'
    signs = list(db.signs.find({}, {"_id": 0}))
    return {"data": signs, "count": len(signs)}