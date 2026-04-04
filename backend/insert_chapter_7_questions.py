# filename: insert_chapter_7_questions.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["questions_chapterwise"]

# --------------------------
# Chapter 7 Questions
# --------------------------
questions = [
    {"chapter": 7, "question": "What is the maximum speed a driver may not exceed?", "options": ["Any speed they like", "Maximum speed fixed by this Ordinance or other laws", "Only on highways", "Only in cities"], "correct_answer": "Maximum speed fixed by this Ordinance or other laws"},
    {"chapter": 7, "question": "Government may restrict speed for:", "options": ["Entertainment purposes", "Public safety or road conditions", "Fuel efficiency", "Driver preference"], "correct_answer": "Public safety or road conditions"},
    {"chapter": 7, "question": "Weight limits for motor vehicles are enforced to:", "options": ["Reduce road taxes", "Prevent overloading and damage", "Encourage heavy vehicles", "Comply with manufacturer only"], "correct_answer": "Prevent overloading and damage"},
    {"chapter": 7, "question": "Pneumatic tyres are:", "options": ["Mandatory for all vehicles unless otherwise prescribed", "Optional", "Only for motorcycles", "Only for public buses"], "correct_answer": "Mandatory for all vehicles unless otherwise prescribed"},
    {"chapter": 7, "question": "Who may require a vehicle to be weighed?", "options": ["Traffic police only", "Any citizen", "Authorized person", "Vehicle owner"], "correct_answer": "Authorized person"},
    {"chapter": 7, "question": "Government can restrict driving vehicles in:", "options": ["Any areas, roads, or bridges", "Only highways", "Only parking lots", "Only near schools"], "correct_answer": "Any areas, roads, or bridges"},
    {"chapter": 7, "question": "Traffic signs must follow rules for:", "options": ["Size, color, type, and authorized transcription", "Only color", "Only size", "Only placement"], "correct_answer": "Size, color, type, and authorized transcription"},
    {"chapter": 7, "question": "Drivers must obey:", "options": ["Traffic signs, Tenth Schedule regulations, and police/electrical device directions", "Only police", "Only traffic signs", "No one"], "correct_answer": "Traffic signs, Tenth Schedule regulations, and police/electrical device directions"},
    {"chapter": 7, "question": "Crash helmets are mandatory for:", "options": ["Driver only", "Pillion rider only", "Both driver and pillion rider", "Passengers"], "correct_answer": "Both driver and pillion rider"},
    {"chapter": 7, "question": "Vehicles must not remain stationary unless:", "options": ["Driver present, brakes applied, or mechanism stopped", "Only driver present", "Only brakes applied", "Anywhere anytime"], "correct_answer": "Driver present, brakes applied, or mechanism stopped"},
    {"chapter": 7, "question": "Two-wheeled motorcycles may carry:", "options": ["Unlimited passengers", "One additional person properly seated behind driver", "Only driver", "Two additional passengers"], "correct_answer": "One additional person properly seated behind driver"},
    {"chapter": 7, "question": "Owner must provide driver info on demand to:", "options": ["Friends", "Police or Transport Department", "Media", "Any citizen"], "correct_answer": "Police or Transport Department"},
    {"chapter": 7, "question": "After an accident, driver must:", "options": ["Run away", "Secure medical attention for injured, report property damage, and inform authorities within 24 hours", "Only inform police", "Only secure their vehicle"], "correct_answer": "Secure medical attention for injured, report property damage, and inform authorities within 24 hours"},
    {"chapter": 7, "question": "Authorized person inspecting vehicle after accident must:", "options": ["Keep vehicle indefinitely", "Communicate place of removal and return within 48 hours", "Charge fine", "Only report"], "correct_answer": "Communicate place of removal and return within 48 hours"},
    {"chapter": 7, "question": "Mechanical or electrical signaling devices rules are made by:", "options": ["Drivers", "Police only", "Government", "Vehicle manufacturer"], "correct_answer": "Government"},
    {"chapter": 7, "question": "Government may prohibit which unsafe practices?", "options": ["Driving downhill with gear disengaged", "Mounting moving vehicle", "Using footpaths", "All of the above"], "correct_answer": "All of the above"},
    {"chapter": 7, "question": "Stationary vehicles must not cause:", "options": ["Danger", "Obstruction", "Inconvenience", "All of the above"], "correct_answer": "All of the above"},
    {"chapter": 7, "question": "Riding on running boards is allowed only for:", "options": ["School children", "Armed forces or police if notified", "All citizens", "Delivery personnel"], "correct_answer": "Armed forces or police if notified"},
    {"chapter": 7, "question": "Owner must produce registration and fitness certificates when demanded by:", "options": ["Any citizen", "Police or Transport officer", "Media", "Vehicle manufacturer"], "correct_answer": "Police or Transport officer"},
    {"chapter": 7, "question": "Government rules may cover:", "options": ["Signaling devices, parking management, emergency exemptions, prevention of danger", "Only signaling devices", "Only parking management", "Only emergency vehicles"], "correct_answer": "Signaling devices, parking management, emergency exemptions, prevention of danger"}
]

# --------------------------
# Insert into MongoDB
# --------------------------
collection.insert_many(questions)

print("✅ Chapter 7 questions inserted successfully!")