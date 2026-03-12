from pydantic import BaseModel, EmailStr
from typing import Optional, Dict
from datetime import datetime


# -----------------------------
# Question Model
# -----------------------------
class Question(BaseModel):
    question: str
    optionA: str
    optionB: str
    optionC: str
    optionD: str
    correctAnswer: str
    explanation: str
    category: str

    # image based questions
    image: Optional[str] = None

    # difficulty for smart exams
    difficulty: Optional[str] = "easy"

    # language support
    language: Optional[str] = "en"


# -----------------------------
# Traffic Sign Model
# -----------------------------
class TrafficSign(BaseModel):
    name: str
    description: str
    image: str
    category: Optional[str] = "regulatory"


# -----------------------------
# User Model
# -----------------------------
class User(BaseModel):
    email: EmailStr
    password: str

    # profile info
    name: Optional[str] = None

    # admin role support
    role: Optional[str] = "user"

    created_at: Optional[datetime] = datetime.utcnow()


# -----------------------------
# Result Model
# -----------------------------
class Result(BaseModel):
    user_id: str
    score: int
    total: int

    # exam type
    exam_type: Optional[str] = "practice"

    # track weak categories
    category_stats: Optional[Dict[str, int]] = {}

    created_at: Optional[datetime] = datetime.utcnow()


# -----------------------------
# Analytics Model
# -----------------------------
class Analytics(BaseModel):
    user_id: str
    tests_taken: int
    average_score: float
    weak_categories: Optional[Dict[str, int]] = {}