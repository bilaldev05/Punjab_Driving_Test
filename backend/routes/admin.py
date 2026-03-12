from fastapi import APIRouter
from models import Question
from database import questions_collection
from schemas import question_serializer

router = APIRouter(prefix="/admin", tags=["Admin"])


@router.post("/add-question")
def add_question(question: Question):

    new_question = question.dict()

    result = questions_collection.insert_one(new_question)

    new_question["_id"] = str(result.inserted_id)

    return {
        "message": "Question added successfully",
        "question": new_question
    }