from fastapi import APIRouter, HTTPException
from models import User
from database.database import results_collection, users_collection, db

router = APIRouter(prefix="/users", tags=["Users"])

from fastapi import APIRouter
from database.database import users_collection

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

    # 🧠 calculate accuracy
    accuracy = score / total if total > 0 else 0

    # 📦 update DB
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
                    "total": total,
                    "accuracy": accuracy   # ✅ IMPORTANT for unlocking logic
                }
            }
        }
    )

    return {
        "message": "Score updated",
        "accuracy": accuracy
    }

@router.get("/unlock-status/{uid}")
def unlock_status(uid: str):

    user = users_collection.find_one({"uid": uid})

    # default: first 2 chapters always unlocked
    if not user:
        return {"unlockedChapters": [1, 2]}

    progress = user.get("chapterProgress", [])

    chapter_best = {}

    # get best accuracy per chapter
    for p in progress:
        ch = p.get("chapter")
        acc = p.get("accuracy", 0)

        if ch is None:
            continue

        chapter_best[ch] = max(chapter_best.get(ch, 0), acc)

    # 🔥 ALWAYS START WITH FIRST 2 CHAPTERS
    unlocked = [1, 2]

    # 🔥 START CHECK FROM CHAPTER 3
    chapter = 3

    while True:
        prev = chapter - 1

        # if previous chapter not played → stop
        if prev not in chapter_best:
            break

        # strict unlock rule
        if chapter_best[prev] >= 0.8:
            unlocked.append(chapter)
            chapter += 1
        else:
            break

    return {"unlockedChapters": unlocked}