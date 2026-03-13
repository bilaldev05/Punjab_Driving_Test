from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client.driving_test
rules_collection = db.rules
rules_collection.delete_many({})

rules = [
    {"title": "Obey Traffic Signals", "description": "Always obey traffic lights and signs."},
    {"title": "Drive on Left Side", "description": "Vehicles must drive on the left side in Pakistan."},
    {"title": "Seat Belts & Helmets", "description": "Seat belts in cars and helmets on motorcycles are mandatory."},
    {"title": "No Mobile Use", "description": "Do not use a mobile phone while driving."},
    {"title": "Check Vehicle Before Driving", "description": "Check brakes, lights, mirrors, fuel, and seat position."},
    {"title": "Observe Speed Limits", "description": "Follow posted speed limits."},
    {"title": "Give Way to Pedestrians", "description": "Always give way at pedestrian crossings."},
    {"title": "No Overloading", "description": "Do not overload passengers or luggage."},
    {"title": "No Alcohol", "description": "Do not drive under the influence of alcohol or drugs."},
    {"title": "Use Indicators", "description": "Always use indicators when turning or changing lanes."}
]

rules_collection.insert_many(rules)
print("✅ Rules guide inserted!")