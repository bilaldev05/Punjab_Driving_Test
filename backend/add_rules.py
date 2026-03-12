from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client.driving_test
rules_collection = db.rules

sample_rules = [
    {
        "title": "Obey Traffic Signals",
        "description": "Always obey traffic lights and signs."
    },
    {
        "title": "Drive on Left",
        "description": "Vehicles in Pakistan must drive on the left side of the road."
    },
    {
        "title": "Seat Belts & Helmets",
        "description": "Wear seat belts in cars and helmets on motorcycles."
    }
]

rules_collection.insert_many(sample_rules)
print("Rules inserted!")