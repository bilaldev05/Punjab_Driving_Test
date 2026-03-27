# insert_rule_book_chapters_3_to_7.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")  # Change if using Atlas
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapters III to VII
# --------------------------
chapters = [
    {
        "chapter_number": 3,
        "title": "CHAPTER-III: REGISTRATION OF MOTOR VEHICLES",
        "sections": [
            "1. Motor vehicles not to be driven without registration.",
            "2. Registration where to be made.",
            "3. Registration how to be made.",
            "4. Temporary Registration.",
            "5. Production of vehicle at the time of registration.",
            "6. Refusal of registration.",
            "7. Effectiveness in West Pakistan of registration.",
            "30. Assignment of fresh registration mark on removal to another province.",
            "1. Change of residence or place of business.",
            "2. Transfer of ownership.",
            "32-A. Cancellation of certificate of registration of vehicles registered in a tribal Areas of Balochistan in certain cases.",
            "1. Alteration in motor vehicle.",
            "2. Suspension of registration.",
            "3. Cancellation of registration.",
            "4. Appeals.",
            "1. Special requirement for registration of transport vehicles.",
            "2. Special particulars to be recorded on registration of transport vehicles.",
            "3. Certificate of fitness of transport vehicles.",
            "4. Registration of vehicles, the property of the Federal Government.",
            "5. Special Registration of vehicles.",
            "6. Application of Chapter-III to trailers.",
            "7. Power to make rules."
        ]
    },
    {
        "chapter_number": 4,
        "title": "CHAPTER-IV: CONTROL OF TRANSPORT VEHICLES",
        "sections": [
            "1. Transport vehicles not to be used or driven without permit.",
            "2. Power of Government to control Road Transport.",
            "3. Transport authorities.",
            "4. General provisions as to applications for permits.",
            "5. Application for stage carriage permit.",
            "6. Procedure of Regional Transport Authority in considering applications for stage carriage permits.",
            "7. Conditions for grant of stage carriage permits.",
            "8. Applications for contract carriage permit.",
            "9. Procedure of Regional Transport Authority in considering application for contract carriage permit.",
            "53. Power to restrict the number of contract carriage and impose conditions on contract carriage permits.",
            "1. Application for private carrier's permit.",
            "2. Procedure of Regional Transport Authority in considering application for a Private carrier's permit.",
            "56. Application for public carrier's permit.",
            "57. Procedure of Regional Transport Authority in considering application for public carrier's permit.",
            "1. Power to restrict the number of and attach conditions to public carrier's permit.",
            "2. Procedure in applying for and granting permits.",
            "3. Duration and renewal of permits.",
            "4. General conditions attaching to all permits.",
            "5. Cancellation and suspension of permit.",
            "6. Transfer of permit on death of holder.",
            "7. Special permits.",
            "8. Validation of permits for use outside regions in which granted.",
            "9. Appeals.",
            "67. Compensation for death of, or injury to, a passenger.",
            "67-A. Claims Tribunal.",
            "67-B. Applications for compensation.",
            "67-C. Award of Compensation.",
            "67-D. Procedure and powers of Claims Tribunal",
            "67-E. Appeal.",
            "67-F. Recovery of amount of compensation.",
            "67-G. Bar of jurisdiction.",
            "1. Power to make rules as to stage carriages and contract carriages.",
            "2. Power to make rules for the purpose of this Chapter."
        ]
    },
    {
        "chapter_number": 5,
        "title": "CHAPTER-V: N.W.F.P. ROAD TRANSPORT BOARD",
        "sections": [
            "1. Road Transport Board.",
            "2. Transport Authorities to have no jurisdiction in respect of motor transport operated by the Board.",
            "72. Powers of the Road Transport Board to acquire property for motor transport operated by it."
        ]
    },
    {
        "chapter_number": 6,
        "title": "CHAPTER-VI: CONSTRUCTION, EQUIPMENT AND MAINTENANCE OF MOTOR VEHICLES",
        "sections": [
            "1. General provisions regarding construction and maintenance.",
            "2. Power to make rule."
        ]
    },
    {
        "chapter_number": 7,
        "title": "CHAPTER-VII: CONTROL OF TRAFFIC",
        "sections": [
            "1. Limits of speed.",
            "2. Limit of weight and limitation on use.",
            "3. Power to have vehicle weighed.",
            "4. Power to restrict the use of vehicles.",
            "5. Power to erect traffic signs.",
            "6. Parking places and halting stations.",
            "7. Main Roads.",
            "8. Duty to obey traffic signs.",
            "9. Signals and signalling devices.",
            "10. Vehicles with left hand control.",
            "11. Leaving vehicle in dangerous position.",
            "12. Riding on running boards.",
            "13. Obstruction of driver.",
            "14. Stationary vehicles.",
            "15. Pillion riding.",
            "89-A. Rider to wear helmet.",
            "1. Duty to produce licence and certificate of registration.",
            "2. Railway crossing.",
            "3. Duty of driver to stop in certain cases.",
            "4. Duty of owner of motor vehicles to give information.",
            "5. Duty of driver in case of accident and injury to a person, Animal or damage to property.",
            "6. Inspection of vehicle involved in accident.",
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
        upsert=True
    )

print("Chapters III to VII inserted successfully!")