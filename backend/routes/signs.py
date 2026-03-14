from fastapi import APIRouter
from database import db

router = APIRouter(prefix="/signs", tags=["Traffic Signs"])

# Remove trailing slash in route to avoid 307 redirect
@router.get("")
def get_signs():
    # Fetch all signs from MongoDB and exclude '_id'
    signs = list(db.signs.find({}, {"_id": 0}))
    return {"data": signs, "count": len(signs)}