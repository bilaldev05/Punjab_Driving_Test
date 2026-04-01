from fastapi import APIRouter
from database import db

router = APIRouter(prefix="/rules", tags=["Rules"])

@router.get("/")
def get_rules():
    rules_cursor = db.rule_book.find({}, {"_id": 0})
    rules = []
    for r in rules_cursor:
        # Split content string by newline into list
        if isinstance(r.get("content"), str):
            r["content"] = [line.strip() for line in r["content"].split("\n") if line.strip()]
        rules.append(r)
    return {"data": rules}