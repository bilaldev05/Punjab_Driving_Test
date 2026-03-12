from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client.driving_test
questions_collection = db.questions

# Sample questions
sample_questions = [
    {
        "question": "What should you do when you see a red traffic light?",
        "optionA": "Go immediately",
        "optionB": "Prepare to stop",
        "optionC": "Stop the vehicle",
        "optionD": "Honk and proceed",
        "correctAnswer": "C",
        "explanation": "A red traffic light means you must stop before the intersection.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "What is the correct action when you hear a siren from an emergency vehicle?",
        "optionA": "Keep driving at same speed",
        "optionB": "Stop immediately in middle of the road",
        "optionC": "Move to left and let it pass",
        "optionD": "Ignore and continue",
        "correctAnswer": "C",
        "explanation": "You must give way to emergency vehicles by moving to left and stopping safely.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Driving on the left side in Pakistan is:",
        "optionA": "Allowed",
        "optionB": "Prohibited",
        "optionC": "Mandatory",
        "optionD": "Optional",
        "correctAnswer": "C",
        "explanation": "In Pakistan, driving on the left side of the road is mandatory.",
        "category": "Traffic Rules",
        "image": ""
    }
]

questions_collection.insert_many(sample_questions)
print("Questions inserted!")