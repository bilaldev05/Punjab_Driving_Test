# filename: insert_chapter_3_questions.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]   # 👈 NEW COLLECTION

# --------------------------
# Questions for Chapter 3
# --------------------------
questions = [
    {
        "chapter": 3,
        "question": "What is required before driving a motor vehicle in a public place?",
        "options": [
            "Insurance only",
            "Registration and registration mark",
            "Driving experience",
            "Fitness certificate"
        ],
        "correct_answer": "Registration and registration mark"
    },
    {
        "chapter": 3,
        "question": "When is a motor vehicle NOT considered registered?",
        "options": [
            "When it has no fuel",
            "When its certificate is suspended or cancelled",
            "When it is new",
            "When it is parked"
        ],
        "correct_answer": "When its certificate is suspended or cancelled"
    },
    {
        "chapter": 3,
        "question": "Where should a vehicle be registered?",
        "options": [
            "Anywhere in Pakistan",
            "Where the owner prefers",
            "In the division where the owner resides or vehicle is kept",
            "Only in Islamabad"
        ],
        "correct_answer": "In the division where the owner resides or vehicle is kept"
    },
    {
        "chapter": 3,
        "question": "How long is a temporary registration valid?",
        "options": [
            "7 days",
            "15 days",
            "1 month",
            "6 months"
        ],
        "correct_answer": "1 month"
    },
    {
        "chapter": 3,
        "question": "Which of the following is a valid reason to refuse registration?",
        "options": [
            "Vehicle is too expensive",
            "Owner is a student",
            "Vehicle is mechanically defective",
            "Owner has no driving experience"
        ],
        "correct_answer": "Vehicle is mechanically defective"
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
collection.insert_many(questions)

print("✅ Chapter 3 questions inserted successfully!")