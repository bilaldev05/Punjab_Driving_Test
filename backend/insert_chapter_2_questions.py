from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

# --------------------------
# Chapter 2 Questions
# --------------------------
questions = [
    {
        "chapter": 2,
        "question": "Can a person drive a motor vehicle in a public place without a licence?",
        "options": [
            "Yes, if experienced",
            "No, a valid driving licence is required",
            "Yes, during daytime only",
            "Only with owner's permission"
        ],
        "answer": 1
    },
    {
        "chapter": 2,
        "question": "What is the minimum age to drive a private motor car?",
        "options": [
            "16 years",
            "17 years",
            "18 years",
            "21 years"
        ],
        "answer": 2
    },
    {
        "chapter": 2,
        "question": "What is the minimum age to drive a heavy transport vehicle?",
        "options": [
            "18 years",
            "20 years",
            "21 years",
            "22 years"
        ],
        "answer": 3
    },
    {
        "chapter": 2,
        "question": "What must drivers above 50 years provide to drive transport vehicles?",
        "options": [
            "Driving experience certificate",
            "Medical certificate",
            "Police clearance",
            "Vehicle fitness certificate"
        ],
        "answer": 1
    },
    {
        "chapter": 2,
        "question": "Who is responsible for ensuring that an unlicensed person does not drive a vehicle?",
        "options": [
            "Traffic police",
            "Vehicle owner",
            "Passenger",
            "Mechanic"
        ],
        "answer": 1
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
result = collection.insert_many(questions)

print(f"✅ Inserted {len(result.inserted_ids)} questions for Chapter 2")