from fastapi import APIRouter
from models import QuestionResult, Result
from database.database import results_collection, users_collection, db

router = APIRouter(prefix="/results", tags=["Results"])

question_results_collection = db["question_results"]
test_results_collection = db["test_results"]


@router.post("/question-result")
def save_question_result(result: QuestionResult):

    results_collection.insert_one({
        "uid": result.user_id,
        "chapter": result.chapter,
        "score": result.score,
        "wrong_answers": result.wrong_answers,
    })

    return {"message": "question saved"}

@router.post("/chapter-result")
def save_chapter_result(result: Result):

    data = result.model_dump()

    accuracy = 0
    if result.total > 0:
        accuracy = result.score / result.total

    # store FINAL TEST RESULT
    test_results_collection.insert_one({
        "uid": result.user_id,
        "chapter": result.chapter,
        "score": result.score,
        "total": result.total,
        "accuracy": accuracy,
        "wrong_answers": data.get("wrong_answers", [])
    })

    # update user stats
    users_collection.update_one(
        {"uid": result.user_id},
        {
            "$inc": {
                "testsTaken": 1,
                "totalScore": result.score
            },
            "$push": {
                "chapterProgress": {
                    "chapter": result.chapter,
                    "score": result.score,
                    "total": result.total,
                    "accuracy": accuracy
                }
            }
        },
        upsert=True
    )

    return {
        "message": "chapter saved",
        "accuracy": accuracy
    }