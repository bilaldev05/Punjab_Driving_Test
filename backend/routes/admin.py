from fastapi import APIRouter
from database import questions_collection
from models import Question

router = APIRouter(prefix="/admin")

@router.post("/add-question")
def add_question(question: Question):

    questions_collection.insert_one(question.dict())

    return {"message": "Question added successfully"}