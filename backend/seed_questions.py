import json
from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["driving_test"]

questions_collection = db["questions"]
signs_collection = db["signs"]

with open("punjab_driving_test_400_questions.json", encoding="utf-8") as f:
    data = json.load(f)

rules = [q for q in data if q["category"] == "rules"]
signs = [q for q in data if q["category"] == "signs"]

questions_collection.insert_many(rules)
signs_collection.insert_many(signs)

print("Inserted Rules:", len(rules))
print("Inserted Signs:", len(signs))