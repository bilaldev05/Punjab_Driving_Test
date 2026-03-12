from fastapi import APIRouter, HTTPException
from models import User
from database import users_collection

router = APIRouter(prefix="/users", tags=["Users"])


@router.post("/register")
def register(user: User):

    existing_user = users_collection.find_one({"email": user.email})

    if existing_user:
        raise HTTPException(status_code=400, detail="Email already exists")

    users_collection.insert_one(user.dict())

    return {"message": "User created successfully"}


@router.post("/login")
def login(user: User):

    db_user = users_collection.find_one({"email": user.email})

    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    if db_user["password"] != user.password:
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {
        "message": "Login successful",
        "user_id": str(db_user["_id"]),
        "email": db_user["email"]
    }