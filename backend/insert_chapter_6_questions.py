# filename: insert_chapter_6_questions.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

# --------------------------
# Questions for Chapter 6
# --------------------------
questions = [
    {
        "chapter": 6,
        "question": "A motor vehicle must always be constructed and maintained so that:",
        "options": [
            "It looks attractive",
            "It runs fast",
            "It is under effective control of the driver",
            "It consumes less fuel"
        ],
        "correct_answer": "It is under effective control of the driver"
    },
    {
        "chapter": 6,
        "question": "Who has the authority to make rules regarding vehicle construction?",
        "options": [
            "Police",
            "Drivers",
            "Government",
            "Courts"
        ],
        "correct_answer": "Government"
    },
    {
        "chapter": 6,
        "question": "Which of the following can Government regulate under this chapter?",
        "options": [
            "Road tax",
            "Vehicle color only",
            "Construction, equipment, and maintenance",
            "Driving license"
        ],
        "correct_answer": "Construction, equipment, and maintenance"
    },
    {
        "chapter": 6,
        "question": "Government rules may regulate the size of:",
        "options": [
            "Driver",
            "Vehicle tyres",
            "Fuel tank only",
            "Engine oil"
        ],
        "correct_answer": "Vehicle tyres"
    },
    {
        "chapter": 6,
        "question": "Which system of a vehicle can be regulated by rules?",
        "options": [
            "Music system",
            "Brake and steering system",
            "Seat covers",
            "Fuel brand"
        ],
        "correct_answer": "Brake and steering system"
    },
    {
        "chapter": 6,
        "question": "Government may regulate emission of:",
        "options": [
            "Water only",
            "Smoke and vapours",
            "Air only",
            "Fuel"
        ],
        "correct_answer": "Smoke and vapours"
    },
    {
        "chapter": 6,
        "question": "Noise produced by vehicles:",
        "options": [
            "Cannot be controlled",
            "Must be increased",
            "Can be regulated by Government rules",
            "Is not important"
        ],
        "correct_answer": "Can be regulated by Government rules"
    },
    {
        "chapter": 6,
        "question": "Government can restrict use of audible signals:",
        "options": [
            "Everywhere always",
            "At certain times or places",
            "Only at night",
            "Only on highways"
        ],
        "correct_answer": "At certain times or places"
    },
    {
        "chapter": 6,
        "question": "Vehicles may be required to undergo:",
        "options": [
            "Painting only",
            "Periodical inspection and testing",
            "Cleaning only",
            "Registration daily"
        ],
        "correct_answer": "Periodical inspection and testing"
    },
    {
        "chapter": 6,
        "question": "Government may regulate which of the following?",
        "options": [
            "Driver salary",
            "Vehicle color for specific purposes",
            "Fuel prices",
            "Road construction"
        ],
        "correct_answer": "Vehicle color for specific purposes"
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
collection.insert_many(questions)

print("✅ Chapter 6 questions inserted successfully!")