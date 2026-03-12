from fastapi import APIRouter
from database import questions_collection
from schemas import question_serializer

router = APIRouter(prefix="/questions", tags=["Questions"])


@router.get("/")
def get_questions():

    questions = []

    for q in questions_collection.find():
        questions.append(question_serializer(q))

    return questions