from fastapi import APIRouter, HTTPException
from models import User
from database import users_collection

router = APIRouter(prefix="/users", tags=["Users"])

from fastapi import APIRouter
from database import users_collection

router = APIRouter(prefix="/users", tags=["Users"])


# 🔥 CREATE USER (UID BASED)
@router.post("/")
def create_user(user: dict):
    existing = users_collection.find_one({"uid": user["uid"]})

    if existing:
        return {"message": "User already exists", "user": existing}

    users_collection.insert_one(user)
    return {"message": "User created"}


# 🔥 GET USER BY UID
@router.get("/{uid}")
def get_user(uid: str):
    user = users_collection.find_one({"uid": uid}, {"_id": 0})
    return user


# 🔥 UPDATE SCORE (UID BASED)
@router.post("/update-score")
def update_score(data: dict):
    uid = data["uid"]
    chapter = data["chapter"]
    score = data["score"]
    total = data["total"]

    user = users_collection.find_one({"uid": uid})

    if not user:
        return {"error": "User not found"}

    users_collection.update_one(
        {"uid": uid},
        {
            "$inc": {
                "totalScore": score,
                "testsTaken": 1
            },
            "$push": {
                "chapterProgress": {
                    "chapter": chapter,
                    "score": score,
                    "total": total
                }
            }
        }
    )

    return {"message": "Score updated"}