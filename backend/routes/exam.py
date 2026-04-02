from fastapi import APIRouter
from database import questions_collection
from schemas import question_serializer

router = APIRouter(prefix="/exam")

# -----------------------------
# RULES TEST
# -----------------------------

@router.get("/rules/{test_number}")
def get_rules_test(test_number: int):

    questions = list(
        questions_collection.find({
            "category": "rules",
            "test_number": test_number
        })
    )

    return [question_serializer(q) for q in questions]



@router.get("/signs/{test_number}")
def get_signs_test(test_number: int):

    questions = list(
        questions_collection.find({
            "category": "signs",
            "test_number": test_number
        })
    )

    return [question_serializer(q) for q in questions]