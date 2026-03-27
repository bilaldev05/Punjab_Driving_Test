# insert_rule_book.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")  # Update if using Atlas or another host
db = client["driving_test"]  # Database name
collection = db["rule_book"]        # Collection name

# --------------------------
# Chapters Data
# --------------------------
chapters = [
    {
        "chapter_number": 1,
        "title": "CHAPTER-I: PRELIMINARY",
        "sections": [
            "1. Short title and extent.",
            "2. Definitions."
        ]
    },
    {
        "chapter_number": 2,
        "title": "CHAPTER-II: LICENSING OF DRIVERS OF MOTOR VEHICLES",
        "sections": [
            "1. Prohibition on driving without licence.",
            "2. Age limit in connection with driving of motor vehicles.",
            "3. Owners of motor vehicles not to permit contravention of section 3 or section 4.",
            "4. Restriction on use of licence by person other than holder.",
            "5. Grant of licence.",
            "6. Form and contents of licence.",
            "7. Additions to licences.",
            "8. Extent of validity of licences.",
            "9. Currency of licences.",
            "10. Renewal of licences.",
            "11. Cancellation of licence on grounds of disease or disability.",
            "12. Order refusing licences and appeals therefrom.",
            "13. Licence to drive motor vehicles, the property of the Federal Government.",
            "1. Power of licensing authority to disqualify for holding a licence.",
            "2. Power of Regional Transport Authority to disqualify.",
            "3. Power of Court to order disqualification.",
            "4. Effect of disqualification order.",
            "5. Endorsement.",
            "6. Transfer of endorsement and issue of licence free from endorsement.",
            "7. Power to make rules."
        ]
    }
]

# --------------------------
# Insert into MongoDB
# --------------------------
for chapter in chapters:
    collection.update_one(
        {"chapter_number": chapter["chapter_number"]},
        {"$set": chapter},
        upsert=True  # Insert if not exists
    )

print("Chapters inserted successfully!")