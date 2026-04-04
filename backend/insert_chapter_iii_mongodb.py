# filename: insert_chapter_iii_mongodb.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")  # Change if using Atlas
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapter III: Registration of Motor Vehicles
# --------------------------
chapter_iii = {
    "chapter": 3,
    "title": "Registration of Motor Vehicles",
    "sections": [
        {
            "section": 23,
            "title": "Motor vehicle not to be driven without registration",
            "subsections": {
                "1": "No person shall drive any motor vehicle and no owner shall permit the vehicle to be driven unless registered and carrying a registration mark.",
                "Explanation": "A motor vehicle is not deemed registered if the certificate of registration has been suspended or cancelled.",
                "2": "Does not apply to vehicles driven within the jurisdiction of a registering authority for registration purposes, or exempted vehicles in possession of a dealer."
            }
        },
        {
            "section": 24,
            "title": "Registration where to be made",
            "subsections": {
                "1": "Vehicle shall be registered by the authority of the division where the owner resides, has business, or normally keeps the vehicle.",
                "2": "Government may require certificates of registration to be presented for entry of further particulars as deemed fit."
            }
        },
        {
            "section": 25,
            "title": "Registration how to be made",
            "subsections": {
                "1": "Application by or on behalf of the owner shall be in Form F and accompanied by the prescribed fee.",
                "2": "Registering authority shall issue certificate of registration in Form G and maintain a record.",
                "3": "A registration mark of six numerals followed by district name in English and Urdu shall be assigned. Certain official vehicles may use a special mark.",
                "4": "Two plates shall be issued to the owner on payment of the prescribed fee.",
                "5": "Vehicles registered before the Provincial Motor Vehicles (Amendment) Ordinance, 1981 may be assigned new marks as notified."
            }
        },
        {
            "section": 26,
            "title": "Temporary registration",
            "subsections": {
                "1": "Owner may apply for temporary registration; authority shall issue temporary certificate and mark.",
                "2": "Temporary registration is valid for one month and non-renewable."
            }
        },
        {
            "section": 27,
            "title": "Production of vehicle at the time of registration",
            "subsections": {
                "1": "Registering authority may require the vehicle to be produced to verify the application and ensure compliance with Chapter VI and rules."
            }
        },
        {
            "section": 28,
            "title": "Refusal of registration",
            "subsections": {
                "1": "Authority may refuse registration if:",
                "1(i)": "Vehicle is mechanically defective and unsafe.",
                "1(ii)": "Vehicle does not comply with Chapter VI or rules.",
                "1(iii)": "Applicant fails to furnish previous registration details.",
                "1(iv)": "Applicant fails to produce certificate of transfer or import licence if applicable.",
                "2": "Authority shall provide the applicant with reasons for refusal free of cost."
            }
        }
        # Continue adding the remaining sections in the same format...
    ]
}

# --------------------------
# Insert / Update in MongoDB
# --------------------------
collection.update_one(
    {"chapter": chapter_iii["chapter"]},
    {"$set": chapter_iii},
    upsert=True
)

print("✅ Chapter III inserted/updated successfully!")