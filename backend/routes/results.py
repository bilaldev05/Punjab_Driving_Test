from fastapi import APIRouter
from models import Result
from database import results_collection

router = APIRouter(prefix="/results", tags=["Results"])


@router.post("/")
def save_result(result: Result):

    result_data = result.dict()

    results_collection.insert_one(result_data)

    return {
        "message": "Result saved successfully"
    }