# chapter_v_mongodb.py

from pymongo import MongoClient

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")  # Adjust if using Atlas
db = client["punjab_driving_test"]
collection = db["rule_book"]

# Chapter V data structured as nested dictionaries and lists
chapter_ix = {
    "chapter": "IX",
    "title": "Miscellaneous",
    "sections": [
        {
            "section_no": 119,
            "title": "Publication of and commencement of rules",
            "subsections": [
                {
                    "subsection_no": 1,
                    "content": "Every power to make rules given by this Ordinance is subject to the condition of the rules being made after previous publication."
                },
                {
                    "subsection_no": 2,
                    "content": "All rules made under this Ordinance shall be published in the official Gazette, and shall, unless some later date is appointed, come into force on the date of such publication."
                }
            ]
        },
        {
            "section_no": 120,
            "title": "Appointment of motor vehicles officers",
            "subsections": [
                {
                    "subsection_no": 1,
                    "content": "Government may, for the purpose of carrying into effect the provisions of this Ordinance, establish a Motor Vehicles Department and a Transport Department and appoint as officers thereof such persons as it thinks fit."
                },
                {
                    "subsection_no": 2,
                    "content": "Every such officer shall be deemed to be a public servant within the meaning of section 21 of the Pakistan Penal Code."
                },
                {
                    "subsection_no": 3,
                    "content": "Government may make rules to regulate the discharge by officers of the Motor Vehicles Department and the Transport Department of their functions, and in particular, prescribe the uniform to be worn, the authorities to which they shall be subordinate, the duties to be performed, the powers to be exercised, and the conditions governing such powers."
                }
            ]
        },
        {
            "section_no": 121,
            "title": "General provisions regarding appeals to prescribed appellate authorities",
            "subsections": [
                {
                    "subsection_no": 1,
                    "content": "An appeal under sub-section (3) of section 14, sub-section (3) of section 16, sub-section (4) of section 17, sub-section (1) of section 36 or section 66 shall not operate as a stay of the order or proceedings under the order appealed from, except so far as the appellate authority may direct."
                },
                {
                    "subsection_no": 2,
                    "content": "In an appeal under this Ordinance, the order appealed from shall not be altered or reversed merely on account of any error, omission or irregularity not materially affecting the merits, in the procedure or order of the original authority."
                }
            ]
        },
        {
            "section_no": 122,
            "title": "Repeal and savings",
            "subsections": [
                {
                    "subsection_no": 1,
                    "content": "The enactments specified in the Fourteen Schedule are hereby repealed to the extent specified against each."
                },
                {
                    "subsection_no": 2,
                    "content": "Notwithstanding the repeal of the enactments specified in the Thirteenth Schedule, everything done, action taken, obligation, liability, penalty or punishment incurred, inquiry or proceeding commenced, officer appointed or person authorised, jurisdiction or power conferred, licence, certificate or permit granted, rule made and order issued under any of the provisions of the said enactments shall if not inconsistent with the provisions of this Ordinance, continue in force and, so far as may be, be deemed to have been respectively done, taken, incurred, commenced, appointed, authorised, conferred, granted, made or issued under this Ordinance."
                }
            ]
        }
    ]
}


# Insert document into MongoDB
result = collection.insert_one(chapter_ix)
print(f"Chapter IX inserted with ID: {result.inserted_id}")