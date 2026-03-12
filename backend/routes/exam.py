from fastapi import APIRouter
from database import questions_collection
from schemas import question_serializer
import random

router = APIRouter(prefix="/exam", tags=["Exam"])


@router.get("/mock")
def get_mock_exam():

    questions = list(questions_collection.find())

    if len(questions) < 30:
        selected = questions
    else:
        selected = random.sample(questions, 30)

    return [question_serializer(q) for q in selected]