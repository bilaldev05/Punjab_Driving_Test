from fastapi import APIRouter
from database import results_collection

router = APIRouter(prefix="/analytics", tags=["Analytics"])


@router.get("/{user_id}")
def user_stats(user_id: str):

    results = list(results_collection.find({"user_id": user_id}))

    total_tests = len(results)

    total_score = sum(r["score"] for r in results)

    average_score = (
        total_score / total_tests if total_tests else 0
    )

    return {
        "tests_taken": total_tests,
        "average_score": average_score,
        "results": results
    }