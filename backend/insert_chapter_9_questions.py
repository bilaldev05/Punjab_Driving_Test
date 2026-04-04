# filename: insert_chapter_9_questions.py

from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

questions = [
    {"chapter": 9, "question": "Before exercising rule-making powers under this Ordinance:", "options": ["No publication needed", "Prior publication is required", "Only verbal notice needed", "Can be enforced immediately"], "correct_answer": "Prior publication is required"},
    {"chapter": 9, "question": "Rules under this Ordinance come into force:", "options": ["Only after government approval", "On the date of publication in the official Gazette unless another date is specified", "Immediately after drafting", "After one month"], "correct_answer": "On the date of publication in the official Gazette unless another date is specified"},
    {"chapter": 9, "question": "Government may establish:", "options": ["Motor Vehicles Departments only", "Transport Departments only", "Both Motor Vehicles and Transport Departments", "None"], "correct_answer": "Both Motor Vehicles and Transport Departments"},
    {"chapter": 9, "question": "Officers appointed under Motor Vehicles/Transport Departments are:", "options": ["Private contractors", "Public servants under section 21 of Pakistan Penal Code", "Temporary employees only", "Volunteers"], "correct_answer": "Public servants under section 21 of Pakistan Penal Code"},
    {"chapter": 9, "question": "Government may make rules for appointed officers regarding:", "options": ["Uniforms", "Duties and powers", "Conditions of service and subordination", "All of the above"], "correct_answer": "All of the above"},
    {"chapter": 9, "question": "An appeal under this Ordinance:", "options": ["Automatically stays the original order", "Does not operate as a stay unless directed by the appellate authority", "Cancels the original order", "Requires court approval"], "correct_answer": "Does not operate as a stay unless directed by the appellate authority"},
    {"chapter": 9, "question": "Orders will not be altered solely because of:", "options": ["Procedural errors or omissions that do not affect the merits", "Mistakes in spelling", "Delay in publication", "Any reason"], "correct_answer": "Procedural errors or omissions that do not affect the merits"},
    {"chapter": 9, "question": "Repealed enactments under this Ordinance:", "options": ["Are completely invalid, no actions continue", "Are repealed only to the extent specified in the Fourteen Schedule", "Continue fully without change", "Require fresh legislation"], "correct_answer": "Are repealed only to the extent specified in the Fourteen Schedule"},
    {"chapter": 9, "question": "Despite repeals, which actions continue in force if consistent with the Ordinance?", "options": ["Only licences", "Only penalties", "All actions, obligations, penalties, inquiries, appointments, jurisdictions, licences, certificates, permits, rules, and orders", "None"], "correct_answer": "All actions, obligations, penalties, inquiries, appointments, jurisdictions, licences, certificates, permits, rules, and orders"}
]

collection.insert_many(questions)
print("✅ Chapter 9 questions inserted successfully!")