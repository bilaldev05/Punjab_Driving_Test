from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["driving_test"]

users_collection = db["users"]
questions_collection = db["questions"]
results_collection = db["results"]
traffic_signs_collection = db ["signs"]
rule_book = db["rule_book"]