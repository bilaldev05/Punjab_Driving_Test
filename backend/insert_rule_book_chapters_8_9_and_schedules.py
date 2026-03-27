# insert_rule_book_chapters_8_9_and_schedules.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")  # Change if using Atlas
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapters VIII and IX + Schedules
# --------------------------
chapters_and_schedules = [
    {
        "chapter_number": 8,
        "title": "CHAPTER-VIII: OFFENCES, PENALTIES AND PROCEDURE",
        "sections": [
            "1. Offences relating to licences.",
            "2. Driving at excessive speed.",
            "3. Driving recklessly or dangerously.",
            "4. Driving while under the influence of drink or drugs.",
            "5. Driving when mentally or physically unfit to drive",
            "6. Punishment for abetment of certain offences.",
            "103. Racing and trials of speed.",
            "1. Using vehicle in unsafe condition.",
            "2. Sale of vehicle in or alteration of vehicle to a condition contravening this Ordinance.",
            "3. Using vehicle without permit.",
            "4. Driving vehicle exceeding permissible weight.",
            "5. Penalty for failing to stop in case of accident or failure to furnish information, etc.",
            "6. Taking vehicle without authority.",
            "7. Unauthorised interference with vehicle.",
            "8. Disobedience of orders, obstruction and refusal of information.",
            "111-A. Penalty of contravention of rules relating to appliances.",
            "1. General provision for punishment of offences not otherwise provided for.",
            "2. Power of arrest without warrant.",
            "3. Power of Police officer to seize documents.",
            "115. Power to detain vehicle used without certificate of registration or permit.",
            "1. Summary disposal of cases.",
            "2. Restriction on conviction.",
            "3. Jurisdiction of Court."
        ]
    },
    {
        "chapter_number": 9,
        "title": "CHAPTER-IX: MISCELLANEOUS",
        "sections": [
            "1. Publication of and commencement of rules.",
            "2. Appointment of motor vehicles officers.",
            "121. General Provisions regarding appeals to prescribed appellate authorities.",
            "122. Repeals and savings."
        ]
    },
    {
        "chapter_number": "schedules",
        "title": "SCHEDULES",
        "sections": [
            "1. First Schedule",
            "2. Second Schedule",
            "3. Third Schedule",
            "4. Fourth Schedule",
            "5. Fifth Schedule",
            "6. Sixth Schedule",
            "7. [Omitted]",
            "8. Eighth Schedule",
            "9. Ninth Schedule",
            "1. Tenth Schedule",
            "2. Eleventh Schedule",
            "3. Twelfth Schedule",
            "4. Thirteenth Schedule",
            ".. Forms",
            ".. Disqualification for driving licence",
            ".. Test of competence to drive",
            ".. Authorities entitled to grant licence",
            ".. Endorsement on licences",
            ".. Registration marks",
            ".. Limits of speed for Motor vehicles",
            ".. Traffic signs",
            ".. Driving regulations",
            ".. Signals",
            ".. Offences",
            ".. Scale of compensation",
            "Fourteenth Schedule - Enactments Repealed"
        ]
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
for item in chapters_and_schedules:
    collection.update_one(
        {"chapter_number": item["chapter_number"]},
        {"$set": item},
        upsert=True
    )

print("Chapters VIII, IX and Schedules inserted successfully!")