from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client.driving_test
signs_collection = db.traffic_signs

sample_signs = [
    {
        "name": "Stop Sign",
        "description": "Come to a complete stop and proceed only when safe.",
        "image": "https://upload.wikimedia.org/wikipedia/commons/3/3b/Stop_sign_light_red.svg"
    },
    {
        "name": "No Entry",
        "description": "Vehicles are prohibited from entering this road.",
        "image": "https://upload.wikimedia.org/wikipedia/commons/f/f7/No_entry_sign.svg"
    },
    {
        "name": "Speed Limit (50 km/h)",
        "description": "Maximum speed allowed is 50 km per hour.",
        "image": "https://upload.wikimedia.org/wikipedia/commons/d/d2/Speed_limit_50_sign.svg"
    }
]

signs_collection.insert_many(sample_signs)
print("Traffic signs inserted!")