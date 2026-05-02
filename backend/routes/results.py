from fastapi import APIRouter
from models import Result
from database.database import results_collection, users_collection

router = APIRouter(prefix="/results", tags=["Results"])

@router.post("/")
def save_result(result: Result):
    print("🔥 RESULT API HIT:", result)

    result_data = result.model_dump()  # FIXED

    # 1. Save result
    insert_result = results_collection.insert_one(result_data)
    print("Inserted ID:", insert_result.inserted_id)

    # 2. Progress
    progress = result.score / result.total if result.total > 0 else 0

    # 3. Update user stats
    users_collection.update_one(
        {"user_id": result.user_id},
        {
            "$inc": {
                "testsTaken": 1,
                "totalScore": result.score
            },
            "$set": {
                "lastChapter": f"Chapter {result.chapter}",
                "progress": progress
            }
        },
        upsert=True
    )

    # 4. Mistakes
    if result.wrong_answers:
        users_collection.update_one(
            {"user_id": result.user_id},
            {
                "$push": {
                    "mistakes": {
                        "$each": result_data["wrong_answers"],
                        "$slice": -20
                    }
                }
            }
        )

    return {
        "message": "Result saved successfully",
        "score": result.score,
        "progress": progress
    }