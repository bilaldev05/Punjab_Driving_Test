# insert_rule_book_chapter_9.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapter IX: Miscellaneous
# --------------------------
chapter_ix = {
    "chapter": 9,
    "title": "Miscellaneous",
    "sections": [

        {
            "section": 119,
            "title": "Publication of and commencement of rules",
            "subsections": {
                "1": "All rule-making powers under this Ordinance require prior publication.",
                "2": "All rules made under this Ordinance shall be published in the official Gazette and come into force on the date of publication unless another date is specified."
            }
        },

        {
            "section": 120,
            "title": "Appointment of motor vehicles officers",
            "subsections": {
                "1": "Government may establish Motor Vehicles and Transport Departments and appoint officers as deemed fit.",
                "2": "All such officers shall be deemed public servants under section 21 of the Pakistan Penal Code.",
                "3": "Government may make rules for the discharge of their functions, including uniforms, duties, powers, subordination, and conditions of service."
            }
        },

        {
            "section": 121,
            "title": "General provisions regarding appeals to prescribed appellate authorities",
            "subsections": {
                "1": "An appeal under this Ordinance does not operate as a stay of the order except as directed by the appellate authority.",
                "2": "Orders shall not be altered solely due to procedural errors or omissions that do not affect the merits."
            }
        },

        {
            "section": 122,
            "title": "Repeals and savings",
            "subsections": {
                "1": "The enactments specified in the Fourteen Schedule are hereby repealed to the extent specified against each.",
                "2": "Despite the repeal, all actions, obligations, penalties, inquiries, appointments, jurisdictions, licences, certificates, permits, rules, and orders under the repealed enactments continue in force if consistent with this Ordinance."
            }
        }

    ]
}

# --------------------------
# Insert / Update
# --------------------------
collection.update_one(
    {"chapter": chapter_ix["chapter"]},
    {"$set": chapter_ix},
    upsert=True
)

print("✅ Chapter IX inserted successfully!")