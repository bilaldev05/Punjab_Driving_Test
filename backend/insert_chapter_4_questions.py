# filename: insert_chapter_4_questions.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

# --------------------------
# Questions for Chapter 4
# --------------------------
questions = [
    {
        "chapter": 4,
        "question": "A transport vehicle can be used in a public place only if:",
        "options": [
            "It has fuel",
            "It has insurance",
            "It has a valid permit",
            "It is new"
        ],
        "correct_answer": "It has a valid permit"
    },
    {
        "chapter": 4,
        "question": "Which authority grants or countersigns permits for transport vehicles?",
        "options": [
            "Police Department",
            "Traffic Wardens",
            "Regional or Provincial Transport Authority",
            "District Court"
        ],
        "correct_answer": "Regional or Provincial Transport Authority"
    },
    {
        "chapter": 4,
        "question": "Which of the following is NOT considered carriage for hire or reward?",
        "options": [
            "Goods delivery for business",
            "Delivery of owner's goods for personal use",
            "Public transport",
            "Taxi service"
        ],
        "correct_answer": "Delivery of owner's goods for personal use"
    },
    {
        "chapter": 4,
        "question": "Which vehicle is exempt from permit requirements?",
        "options": [
            "Private car",
            "Government vehicle used for public purpose",
            "Taxi",
            "Bus"
        ],
        "correct_answer": "Government vehicle used for public purpose"
    },
    {
        "chapter": 4,
        "question": "Government can control road transport by:",
        "options": [
            "Issuing passports",
            "Fixing fares and freights",
            "Selling vehicles",
            "Repairing roads"
        ],
        "correct_answer": "Fixing fares and freights"
    },
    {
        "chapter": 4,
        "question": "Who constitutes Transport Authorities?",
        "options": [
            "Supreme Court",
            "Government",
            "Police",
            "Drivers"
        ],
        "correct_answer": "Government"
    },
    {
        "chapter": 4,
        "question": "Application for a permit is made to:",
        "options": [
            "Police station",
            "Motorway office",
            "Regional Transport Authority",
            "Court"
        ],
        "correct_answer": "Regional Transport Authority"
    },
    {
        "chapter": 4,
        "question": "Temporary permits or special permits are issued for:",
        "options": [
            "Lifetime use",
            "One return trip",
            "10 years",
            "Permanent use"
        ],
        "correct_answer": "One return trip"
    },
    {
        "chapter": 4,
        "question": "Duration of a stage carriage permit is usually:",
        "options": [
            "6 months",
            "1–3 years",
            "10 years",
            "Lifetime"
        ],
        "correct_answer": "1–3 years"
    },
    {
        "chapter": 4,
        "question": "Within how many days can a person file an appeal?",
        "options": [
            "7 days",
            "15 days",
            "30 days",
            "60 days"
        ],
        "correct_answer": "30 days"
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
collection.insert_many(questions)

print("✅ Chapter 4 questions inserted successfully!")