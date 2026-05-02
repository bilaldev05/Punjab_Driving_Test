from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from database.database import users_collection
from datetime import date
from routes import survival
from services.ai_service import get_ai_suggestion
from services.ai_service import get_ai_suggestion
from services.ai_helper import extract_weak_topics, format_mistakes
import json
from database.redis_client import redis_client



from routes import (
    rulebook,
    users,
    questions,
    results,
    exam,
   survival,
    signs,
    
)



app = FastAPI(title="Punjab Driving Test API")


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(users.router)
app.include_router(questions.router)
app.include_router(results.router)
app.include_router(exam.router)

app.include_router(signs.router)
app.include_router(survival.router)
app.include_router(rulebook.router)






@app.get("/")
def home():
    return {"message": "Punjab Driving Test API running"}

class DashboardResponse(BaseModel):
    xp: int
    streak: int
    progress: float
    continueChapter: str

def get_or_create_user(user_id: str):
    user = users_collection.find_one({"user_id": user_id})

    if not user:
        new_user = {
            "user_id": user_id,
            "xp": 0,
            "streak": 0,
            "progress": 0.0,
            "continueChapter": "Chapter 1 • Intro",
            "lastActiveDate": ""
        }

        users_collection.insert_one(new_user)
        return new_user

    return user

@app.get("/dashboard/{user_id}")
def get_dashboard(user_id: str):
    user = users_collection.find_one({"user_id": user_id})  

    if not user:
        user = get_or_create_user(user_id)

    return {
        "xp": user.get("xp", 0),
        "streak": user.get("streak", 0),
        "progress": user.get("progress", 0.0),
        "continueChapter": user.get("continueChapter", "")
    }

class XPUpdate(BaseModel):
    user_id: str
    xp: int

@app.post("/add-xp")
def add_xp(data: XPUpdate):
    user = users_collection.find_one({"user_id": data.user_id})

    
    if not user:
        users_collection.insert_one({
            "user_id": data.user_id,
            "xp": data.xp,
            "streak": 0
        })

        return {
            "message": "User created and XP added",
            "xp": data.xp
        }

    # 🔥 update XP safely
    users_collection.update_one(
        {"user_id": data.user_id},
        {"$inc": {"xp": data.xp}}
    )

   
    updated_user = users_collection.find_one({"user_id": data.user_id})

    return {
        "message": "XP added successfully",
        "xp": updated_user.get("xp", 0)
    }

class ChapterUpdate(BaseModel):
    user_id: str
    chapter: str
    progress: float


@app.post("/update-chapter")
def update_chapter(data: ChapterUpdate):
    users_collection.update_one(
        {"user_id": data.user_id},
        {
            "$set": {
                "continueChapter": data.chapter,
                "progress": float(data.progress)
            }
        }
    )

    return {"message": "Chapter updated"}

@app.post("/update-streak/{user_id}")
def update_streak(user_id: str):
    user = users_collection.find_one({"user_id": user_id})

    if not user:
        user = get_or_create_user(user_id)

    today = str(date.today())
    last = user.get("lastActiveDate", "")

    if last != today:
        users_collection.update_one(
            {"user_id": user_id},
            {
                "$inc": {"streak": 1},
                "$set": {"lastActiveDate": today}
            }
        )

    return {"message": "Streak updated"}





@app.get("/ai-coach/{user_id}")
def ai_coach(user_id: str):
    cache_key = f"ai_coach:{user_id}"

    
    cached = redis_client.get(cache_key)
    if cached:
        return {"advice": cached}

   
    user = users_collection.find_one({"user_id": user_id})

    if not user:
        return {"message": "User not found"}

    data = {
        "xp": user.get("xp", 0),
        "streak": user.get("streak", 0),
        "progress": user.get("progress", 0),
        "weak_topics": extract_weak_topics(user.get("mistakes", [])),
        "wrong_answers": format_mistakes(user.get("mistakes", []))
    }

    suggestion = get_ai_suggestion(data)

    
    redis_client.setex(
        cache_key,
        3600,  # 1 hour cache
        suggestion
    )

    return {"advice": suggestion}

    # python -m uvicorn main:app --reload 