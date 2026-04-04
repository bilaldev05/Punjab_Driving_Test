# filename: insert_chapter_i_mongodb.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapter I: Preliminary
# --------------------------
chapter_i = {
    "chapter": 1,
    "title": "Preliminary",
    "sections": [
        {"section": 1, "title": "Short title and extent"},
        {"section": 2, "title": "Definitions"}
    ]
}

# --------------------------
# Upsert Chapter I in MongoDB
# --------------------------
collection.update_one(
    {"chapter": chapter_i["chapter"]},
    {"$set": chapter_i},
    upsert=True
)

print("✅ Chapter I inserted/updated successfully!")