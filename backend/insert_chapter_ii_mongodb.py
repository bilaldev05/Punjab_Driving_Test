# insert_chapter_2_structured.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapter II: Licensing of Drivers
# --------------------------
chapter_ii = {
    "chapter": 2,
    "title": "Licensing of Drivers of Motor Vehicles",
    "sections": [
        {
            "section": 3,
            "title": "Prohibition on driving without licence",
            "subsections": {
                "1": "No person shall drive a motor vehicle in any public place unless he holds an effective driving licence.",
                "1A": "No person shall drive a public service vehicle or work as a paid driver unless specifically authorized in the licence.",
                "2": "Learner drivers may drive under conditions prescribed by the Government.",
                "3": "Driver must carry the latest version of the Pakistan Highway Code."
            }
        },
        {
            "section": 4,
            "title": "Age limit for driving motor vehicles",
            "subsections": {
                "1": {
                    "description": "Minimum age requirements:",
                    "points": {
                        "i": "Motorcycle or invalid carriage: 18 years",
                        "ii": "Motor car (private): 18 years",
                        "iii": "Motor car (paid) or transport vehicle: 21 years",
                        "iv": "Heavy transport vehicle: 22 years"
                    }
                },
                "2": {
                    "description": "Medical requirements for older drivers:",
                    "points": {
                        "a": "Drivers above 50 must provide medical certificate",
                        "b": "Must not suffer from diseases causing danger to public",
                        "c": "Certificate valid for 12 months (renewable)"
                    }
                },
                "3": "No person shall drive with obstructed vision."
            }
        },
        {
            "section": 5,
            "title": "Responsibility of vehicle owner",
            "subsections": {
                "1": "Owner must not allow unlicensed or ineligible person to drive."
            }
        },
        {
            "section": 6,
            "title": "Restriction on use of licence",
            "subsections": {
                "1": "Licence holder shall not allow any other person to use their licence."
            }
        },
        {
            "section": 7,
            "title": "Grant of licence",
            "subsections": {
                "1": "Eligible persons may apply to licensing authority.",
                "2": "Application must be in prescribed form with required details.",
                "3": "Medical certificate required for transport or paid drivers.",
                "4": "Applicant must submit attested photographs.",
                "5": {
                    "description": "Licence refusal conditions:",
                    "points": {
                        "a": "Applicant suffering from dangerous disease",
                        "b": "Licence may be limited for disabled persons",
                        "c": "Applicant may undergo fitness test"
                    }
                },
                "6": {
                    "description": "Driving test requirement:",
                    "points": {
                        "a": "Applicant must pass driving test",
                        "b": "Test may be waived for certified drivers",
                        "c": "Armed forces drivers (3+ years experience) may be exempt"
                    }
                }
            }
        }
    ]
}

# --------------------------
# Insert / Update MongoDB
# --------------------------
collection.update_one(
    {"chapter": chapter_ii["chapter"]},
    {"$set": chapter_ii},
    upsert=True
)

print("✅ Chapter II structured data inserted successfully!")