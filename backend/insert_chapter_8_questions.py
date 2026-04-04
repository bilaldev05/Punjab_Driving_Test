# filename: insert_chapter_8_questions.py

from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

questions = [
    {"chapter": 8, "question": "Driving without a valid licence can lead to:", "options": ["Fine up to Rs. 500", "Imprisonment up to 6 months", "Both A and B", "No penalty"], "correct_answer": "Both A and B"},
    {"chapter": 8, "question": "Transport vehicle driven without a valid licence:", "options": ["Fine Rs. 500", "Imprisonment up to 2 years and fine up to Rs. 1000", "Only warning", "None"], "correct_answer": "Imprisonment up to 2 years and fine up to Rs. 1000"},
    {"chapter": 8, "question": "A licence obtained fraudulently is:", "options": ["Valid", "Invalid", "Requires court approval", "Only valid for 1 year"], "correct_answer": "Invalid"},
    {"chapter": 8, "question": "Excessive speed penalties for transport vehicles:", "options": ["Rs. 100–500", "Rs. 1000", "No penalty", "Rs. 50"], "correct_answer": "Rs. 100–500"},
    {"chapter": 8, "question": "Employer forcing driver to overspeed may be fined:", "options": ["Rs. 100", "Rs. 200–500", "Rs. 1000", "No fine"], "correct_answer": "Rs. 200–500"},
    {"chapter": 8, "question": "Reckless driving penalties for transport vehicles (first offence):", "options": ["Imprisonment up to 6 months", "Imprisonment up to 1 year + fine up to Rs. 1000", "Only fine Rs. 500", "No penalty"], "correct_answer": "Imprisonment up to 1 year + fine up to Rs. 1000"},
    {"chapter": 8, "question": "Repeat reckless driving can result in:", "options": ["Imprisonment up to 2–4 years", "Fine Rs. 100", "Community service", "Warning"], "correct_answer": "Imprisonment up to 2–4 years"},
    {"chapter": 8, "question": "Driving under influence (first offence) punishment:", "options": ["Imprisonment up to 6 months or fine up to Rs. 1000", "Only warning", "Rs. 200", "Community service"], "correct_answer": "Imprisonment up to 6 months or fine up to Rs. 1000"},
    {"chapter": 8, "question": "Driving under influence (repeat offence) punishment:", "options": ["Fine Rs. 100", "Imprisonment up to 2 years", "No penalty", "Only warning"], "correct_answer": "Imprisonment up to 2 years"},
    {"chapter": 8, "question": "Driving while medically unfit first offence:", "options": ["Fine up to Rs. 200", "Imprisonment", "Warning only", "No penalty"], "correct_answer": "Fine up to Rs. 200"},
    {"chapter": 8, "question": "Abetment of offences under sections 99–101:", "options": ["Lesser punishment", "Same punishment as principal offence", "Only warning", "No punishment"], "correct_answer": "Same punishment as principal offence"},
    {"chapter": 8, "question": "Unauthorized racing punishment:", "options": ["Imprisonment up to 6 months or fine Rs. 1000", "Only fine Rs. 100", "Warning", "No penalty"], "correct_answer": "Imprisonment up to 6 months or fine Rs. 1000"},
    {"chapter": 8, "question": "Driving defective vehicle without accident:", "options": ["Fine Rs. 500 or imprisonment 1 month", "Only fine Rs. 100", "Warning", "No penalty"], "correct_answer": "Fine Rs. 500 or imprisonment 1 month"},
    {"chapter": 8, "question": "If accident occurs with unsafe vehicle:", "options": ["Fine Rs. 1000 or imprisonment up to 6 months", "Warning", "Rs. 500 only", "No penalty"], "correct_answer": "Fine Rs. 1000 or imprisonment up to 6 months"},
    {"chapter": 8, "question": "Selling unsafe vehicles:", "options": ["Fine up to Rs. 200", "Imprisonment 1 month", "Warning", "No penalty"], "correct_answer": "Fine up to Rs. 200"},
    {"chapter": 8, "question": "Using vehicle without permit (repeat offence):", "options": ["Imprisonment up to 2 years or fine Rs. 1000", "Fine Rs. 100", "Warning", "Only imprisonment"], "correct_answer": "Imprisonment up to 2 years or fine Rs. 1000"},
    {"chapter": 8, "question": "Overloading vehicle punishment:", "options": ["Fine up to Rs. 100", "Fine up to Rs. 500 for repeat offence", "Both A & B", "Warning"], "correct_answer": "Both A & B"},
    {"chapter": 8, "question": "Failure to stop/report accident:", "options": ["Imprisonment up to 6 months or fine Rs. 1000", "Warning", "Only fine Rs. 100", "Community service"], "correct_answer": "Imprisonment up to 6 months or fine Rs. 1000"},
    {"chapter": 8, "question": "Taking vehicle without authority punishment:", "options": ["Imprisonment up to 3 months or fine Rs. 500", "Fine Rs. 200", "Warning", "No penalty"], "correct_answer": "Imprisonment up to 3 months or fine Rs. 500"},
    {"chapter": 8, "question": "Tampering with vehicle punishment:", "options": ["Imprisonment up to 1 month or fine Rs. 200", "Fine Rs. 500", "Warning", "No penalty"], "correct_answer": "Imprisonment up to 1 month or fine Rs. 200"},
    {"chapter": 8, "question": "Carrying illegal appliances:", "options": ["Fine up to Rs. 500", "Imprisonment 1 month", "Warning", "No penalty"], "correct_answer": "Fine up to Rs. 500"},
    {"chapter": 8, "question": "Arrest without warrant allowed when:", "options": ["Minor offences", "Serious offences", "Only traffic violations", "Only by Magistrate"], "correct_answer": "Serious offences"},
    {"chapter": 8, "question": "Police may seize:", "options": ["Fake licences or documents", "Any vehicle", "Only motorbikes", "Only transport vehicles"], "correct_answer": "Fake licences or documents"},
    {"chapter": 8, "question": "Vehicle without registration or permit may be:", "options": ["Detained", "Ignored", "Only fined", "Only warned"], "correct_answer": "Detained"},
    {"chapter": 8, "question": "On-spot fines must be paid within:", "options": ["3 days", "7 days", "14 days", "28 days"], "correct_answer": "7 days"}
]

collection.insert_many(questions)
print("✅ Chapter 8 questions inserted successfully!")