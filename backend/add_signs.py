from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client.driving_test
signs_collection = db.traffic_signs


signs_collection.delete_many({})  # clear existing signs

signs = [
    {"name": "Stop Sign", "description": "Stop completely before intersection.", "image": "https://upload.wikimedia.org/wikipedia/commons/3/3b/Stop_sign_light_red.svg"},
    {"name": "No Entry", "description": "Vehicles prohibited from entering.", "image": "https://upload.wikimedia.org/wikipedia/commons/f/f7/No_entry_sign.svg"},
    {"name": "Speed Limit 50 km/h", "description": "Maximum speed is 50 km/h.", "image": "https://upload.wikimedia.org/wikipedia/commons/d/d2/Speed_limit_50_sign.svg"},
    {"name": "Pedestrian Crossing", "description": "Watch for pedestrians.", "image": "https://upload.wikimedia.org/wikipedia/commons/9/98/Zebra_crossing_flag_sign_%28Pakistan%29.svg"},
    {"name": "No U-Turn", "description": "U-turn is prohibited.", "image": "https://upload.wikimedia.org/wikipedia/commons/b/bc/No_U-turn_sign.svg"},
    {"name": "Give Way / Yield", "description": "Slow down and give way.", "image": "https://upload.wikimedia.org/wikipedia/commons/3/33/Yield_sign.svg"},
    {"name": "Roundabout Ahead", "description": "Roundabout ahead; slow down.", "image": "https://upload.wikimedia.org/wikipedia/commons/e/e2/Roundabout_sign.svg"},
    {"name": "School Zone", "description": "Drive carefully; children may be crossing.", "image": "https://upload.wikimedia.org/wikipedia/commons/f/fb/School_zone_sign.svg"},
    {"name": "No Parking", "description": "Parking prohibited in this area.", "image": "https://upload.wikimedia.org/wikipedia/commons/5/55/No_parking_sign.svg"},
    {"name": "Railway Crossing", "description": "Be prepared to stop for trains.", "image": "https://upload.wikimedia.org/wikipedia/commons/3/30/Railway_crossing_sign.svg"},
    {"name": "U-turn Permitted", "description": "U-turn allowed here.", "image": "https://upload.wikimedia.org/wikipedia/commons/f/fd/U-turn_sign.svg"},
    {"name": "Slippery Road", "description": "Drive carefully; slippery conditions.", "image": "https://upload.wikimedia.org/wikipedia/commons/8/8c/Slippery_road_sign.svg"},
    {"name": "Two-way Traffic", "description": "Traffic flows in both directions.", "image": "https://upload.wikimedia.org/wikipedia/commons/6/69/Two-way_traffic_sign.svg"},
    {"name": "Traffic Signals Ahead", "description": "Traffic lights ahead.", "image": "https://upload.wikimedia.org/wikipedia/commons/2/2c/Traffic_signals_ahead.svg"},
    {"name": "Roundabout", "description": "Circular intersection ahead.", "image": "https://upload.wikimedia.org/wikipedia/commons/e/e2/Roundabout_sign.svg"},
    {"name": "Narrow Bridge", "description": "Bridge ahead is narrow; proceed carefully.", "image": "https://upload.wikimedia.org/wikipedia/commons/7/79/Narrow_bridge_sign.svg"},
    {"name": "Steep Hill", "description": "Steep hill ahead; drive cautiously.", "image": "https://upload.wikimedia.org/wikipedia/commons/7/7a/Steep_hill_sign.svg"},
    {"name": "Animal Crossing", "description": "Animals may cross the road; drive carefully.", "image": "https://upload.wikimedia.org/wikipedia/commons/2/2c/Animal_crossing_sign.svg"},
    {"name": "Falling Rocks", "description": "Be cautious of rocks falling from hillside.", "image": "https://upload.wikimedia.org/wikipedia/commons/1/1b/Falling_rocks_sign.svg"},
    {"name": "No Horn", "description": "Use horn only in emergencies.", "image": "https://upload.wikimedia.org/wikipedia/commons/7/73/No_horn_sign.svg"}
]

signs_collection.insert_many(signs)
print("✅ 20 traffic signs inserted!")
