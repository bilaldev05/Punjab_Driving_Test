from fastapi import APIRouter
from pymongo import MongoClient
from datetime import datetime

router = APIRouter(prefix="/survival", tags=["Survival"])

client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]

users = db["users"]
questions = db["questions_chapterwise"]
survival_scores = db["survival_scores"]


# -----------------------------
# GET RANDOM QUESTIONS
# -----------------------------
@router.get("/questions")
def get_random_questions():
    data = list(questions.aggregate([{"$sample": {"size": 20}}]))
    for q in data:
        q["_id"] = str(q["_id"])
    return data


# -----------------------------
# SAVE SURVIVAL RESULT
# -----------------------------
@router.post("/result")
def save_survival_result(data: dict):
    name = data.get("name")
    score = data.get("score")

    survival_scores.insert_one({
        "name": name,
        "score": score,
        "date": datetime.now()
    })

    # update user total score
    users.update_one(
        {"name": name},
        {
            "$inc": {
                "totalScore": score,
                "testsTaken": 1
            }
        }
    )

    return {"message": "Saved"}


@router.post("/survival")
def save_survival_score(data: dict):
    name = data.get("name")
    score = data.get("score")

    xp_gain = score // 2   # 🔥 convert score → XP (custom logic)

    users.update_one(
        {"name": name},
        {
            "$inc": {
                "xp": xp_gain,
                "total_score": score
            }
        },
        upsert=True
    )

    return {
        "message": "Saved",
        "xp_gained": xp_gain
    }