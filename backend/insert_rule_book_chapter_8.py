# insert_rule_book_chapter_8.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapter VIII: Offences, Penalties and Procedure
# --------------------------
chapter_viii = {
    "chapter": 8,
    "title": "Offences, Penalties and Procedure",
    "sections": [

        {
            "section": 97,
            "title": "Offences relating to licences",
            "subsections": {
                "1": "Driving without valid licence or while disqualified is punishable with imprisonment up to 6 months or fine up to Rs. 500 or both.",
                "2": "For transport vehicles: imprisonment up to 2 years and fine up to Rs. 1000.",
                "3": "Any licence obtained fraudulently becomes invalid."
            }
        },

        {
            "section": 98,
            "title": "Driving at excessive speed",
            "subsections": {
                "1": "Violation of speed limits: fine up to Rs. 100 (transport vehicle: Rs. 100–500).",
                "2": "Employer forcing driver to overspeed: fine up to Rs. 200–500.",
                "3": "Conviction requires mechanical evidence of speed.",
                "4": "Unrealistic time schedules may be treated as evidence of offence."
            }
        },

        {
            "section": 99,
            "title": "Reckless or dangerous driving",
            "subsections": {
                "1": "Dangerous driving: imprisonment up to 6 months or fine up to Rs. 500.",
                "2": "Transport vehicle: imprisonment up to 1 year + fine up to Rs. 1000.",
                "3": "Repeat offence: imprisonment up to 2–4 years depending on vehicle type."
            }
        },

        {
            "section": 100,
            "title": "Driving under influence",
            "subsections": {
                "1": "Driving under influence of drugs/alcohol: imprisonment up to 6 months or fine up to Rs. 1000.",
                "2": "Repeat offence: imprisonment up to 2 years."
            }
        },

        {
            "section": 101,
            "title": "Driving while unfit",
            "subsections": {
                "1": "Driving with medical condition: fine up to Rs. 200.",
                "2": "Repeat offence: fine up to Rs. 500."
            }
        },

        {
            "section": 102,
            "title": "Abetment of offences",
            "subsections": {
                "1": "Abetting offences under sections 99–101 carries same punishment."
            }
        },

        {
            "section": 103,
            "title": "Racing and trials of speed",
            "subsections": {
                "1": "Unauthorized racing: imprisonment up to 6 months or fine up to Rs. 1000."
            }
        },

        {
            "section": 104,
            "title": "Unsafe vehicles",
            "subsections": {
                "1": "Driving defective vehicle: imprisonment up to 1 month or fine Rs. 500.",
                "2": "If accident occurs: imprisonment up to 6 months or fine Rs. 1000."
            }
        },

        {
            "section": 105,
            "title": "Sale of unsafe vehicles",
            "subsections": {
                "1": "Selling unsafe vehicles: fine up to Rs. 200."
            }
        },

        {
            "section": 106,
            "title": "Using vehicle without permit",
            "subsections": {
                "1": "Violation: imprisonment up to 6 months or fine Rs. 500.",
                "2": "Repeat offence: imprisonment up to 2 years or fine Rs. 1000.",
                "3": "Emergency use is exempted if reported within 7 days."
            }
        },

        {
            "section": 107,
            "title": "Weight violations",
            "subsections": {
                "1": "Overloading or violating permit: fine up to Rs. 100.",
                "2": "Repeat offence: fine up to Rs. 500."
            }
        },

        {
            "section": 108,
            "title": "Failure after accident",
            "subsections": {
                "1": "Failure to stop/report accident: imprisonment up to 6 months or fine Rs. 1000."
            }
        },

        {
            "section": 109,
            "title": "Taking vehicle without authority",
            "subsections": {
                "1": "Unauthorized use: imprisonment up to 3 months or fine Rs. 500."
            }
        },

        {
            "section": 110,
            "title": "Tampering with vehicle",
            "subsections": {
                "1": "Unauthorized interference: imprisonment up to 1 month or fine Rs. 200."
            }
        },

        {
            "section": 111,
            "title": "Disobedience and obstruction",
            "subsections": {
                "1": "Disobeying authorities or giving false info: fine up to Rs. 200."
            }
        },

        {
            "section": "111-A",
            "title": "Illegal appliances",
            "subsections": {
                "1": "Carrying prohibited devices: fine up to Rs. 500."
            }
        },

        {
            "section": 112,
            "title": "General offences",
            "subsections": {
                "1": "Violation without specific penalty: fine up to Rs. 100.",
                "2": "Repeat offence: fine up to Rs. 500."
            }
        },

        {
            "section": 113,
            "title": "Arrest without warrant",
            "subsections": {
                "1": "Police may arrest without warrant in serious offences.",
                "2": "Medical exam required for intoxication cases within 2 hours."
            }
        },

        {
            "section": 114,
            "title": "Seizure of documents",
            "subsections": {
                "1": "Police may seize fake licences or documents.",
                "2": "Temporary acknowledgement may be issued."
            }
        },

        {
            "section": 115,
            "title": "Vehicle detention",
            "subsections": {
                "1": "Vehicles without registration or permit may be detained."
            }
        },

        {
            "section": 116,
            "title": "Summary disposal",
            "subsections": {
                "1": "Accused may plead guilty via post.",
                "2": "Fine may be paid without court appearance."
            }
        },

        {
            "section": "116-A",
            "title": "On-spot fines",
            "subsections": {
                "1": "Police may issue on-spot fines.",
                "2": "Payment within 7 days avoids court proceedings."
            }
        },

        {
            "section": 117,
            "title": "Restriction on conviction",
            "subsections": {
                "1": "Notice must be given within 14 days.",
                "2": "Summons within 28 days required."
            }
        },

        {
            "section": 118,
            "title": "Jurisdiction of courts",
            "subsections": {
                "1": "Only Magistrate Second Class or above may try offences."
            }
        }
    ]
}

# --------------------------
# Insert / Update
# --------------------------
collection.update_one(
    {"chapter": chapter_viii["chapter"]},
    {"$set": chapter_viii},
    upsert=True
)

print("✅ Chapter VIII inserted successfully!")