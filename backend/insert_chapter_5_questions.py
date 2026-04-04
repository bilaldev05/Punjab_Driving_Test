# filename: insert_chapter_5_questions.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

# --------------------------
# Questions for Chapter 5
# --------------------------
questions = [
    {
        "chapter": 5,
        "question": "What is the nature of the Road Transport Board?",
        "options": [
            "Private company",
            "Government office only",
            "Body corporate with perpetual succession",
            "Temporary committee"
        ],
        "correct_answer": "Body corporate with perpetual succession"
    },
    {
        "chapter": 5,
        "question": "Who appoints the Chairman and members of the Board?",
        "options": [
            "Supreme Court",
            "Public voting",
            "Government",
            "Transport Authority"
        ],
        "correct_answer": "Government"
    },
    {
        "chapter": 5,
        "question": "What is the usual term of office of Board members?",
        "options": [
            "1 year",
            "2 years",
            "3 years",
            "5 years"
        ],
        "correct_answer": "3 years"
    },
    {
        "chapter": 5,
        "question": "Which authority has NO jurisdiction over transport operated by the Board?",
        "options": [
            "Police",
            "Provincial or Regional Transport Authority",
            "Courts",
            "Drivers"
        ],
        "correct_answer": "Provincial or Regional Transport Authority"
    },
    {
        "chapter": 5,
        "question": "Disputes regarding compensation for acquired property are decided by:",
        "options": [
            "Police officer",
            "District court",
            "Arbitrator who is or has been a High Court Judge",
            "Transport Authority"
        ],
        "correct_answer": "Arbitrator who is or has been a High Court Judge"
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
collection.insert_many(questions)

print("✅ Chapter 5 questions inserted successfully!") 