from fastapi import APIRouter
from pymongo import MongoClient
from typing import List

router = APIRouter(prefix="/questions", tags=["Questions"])

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]


# -----------------------------
# GET QUESTIONS BY CHAPTER
# -----------------------------
@router.get("/{chapter}")
def get_questions_by_chapter(chapter: int):
    questions = list(
        collection.find(
            {"chapter": chapter},
            {"_id": 0, "chapter": 1, "question": 1, "options": 1, "answer": 1}
        )
    )
    # ensure answer is integer
    for q in questions:
        if 'answer' in q and q['answer'] is not None:
            q['answer'] = int(q['answer'])
        else:
            q['answer'] = 0  # default if missing
    return questions