from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017/")
db = client.driving_test

# ---------- 20 Sample Punjab Driving Questions ----------
questions_collection = db.questions
questions_collection.delete_many({})  # clear existing data

questions = [
    {
        "question": "What should you do when you see a red traffic light?",
        "optionA": "Go immediately",
        "optionB": "Prepare to stop",
        "optionC": "Stop the vehicle",
        "optionD": "Honk and proceed",
        "correctAnswer": "C",
        "explanation": "Red light means stop before intersection.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "At a stop sign, what is required?",
        "optionA": "Slow down",
        "optionB": "Stop completely",
        "optionC": "Honk and move",
        "optionD": "Ignore it",
        "correctAnswer": "B",
        "explanation": "You must stop completely at a stop sign.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Driving on the left side in Pakistan is:",
        "optionA": "Optional",
        "optionB": "Prohibited",
        "optionC": "Mandatory",
        "optionD": "Only on highways",
        "correctAnswer": "C",
        "explanation": "Vehicles must drive on the left side.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "When must you give way to pedestrians?",
        "optionA": "Only at night",
        "optionB": "Only on highways",
        "optionC": "At pedestrian crossings",
        "optionD": "Never",
        "correctAnswer": "C",
        "explanation": "Pedestrians have priority at crossings.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Using a mobile phone while driving is:",
        "optionA": "Allowed",
        "optionB": "Allowed only on highways",
        "optionC": "Prohibited",
        "optionD": "Allowed with headphones",
        "correctAnswer": "C",
        "explanation": "Using a mobile phone while driving is prohibited.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "What should you do when an emergency vehicle approaches?",
        "optionA": "Keep driving",
        "optionB": "Move to left and stop",
        "optionC": "Overtake quickly",
        "optionD": "Stop in middle of road",
        "correctAnswer": "B",
        "explanation": "Move left and let emergency vehicles pass.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Seat belts are mandatory for:",
        "optionA": "Driver only",
        "optionB": "Passengers only",
        "optionC": "Driver and front-seat passenger",
        "optionD": "No one",
        "correctAnswer": "C",
        "explanation": "Driver and front-seat passengers must wear seat belts.",
        "category": "Safety Rules",
        "image": ""
    },
    {
        "question": "Wearing a helmet while riding a motorcycle is:",
        "optionA": "Optional",
        "optionB": "Mandatory",
        "optionC": "Optional on highways",
        "optionD": "Only for passengers",
        "correctAnswer": "B",
        "explanation": "Helmet is mandatory for riders and passengers.",
        "category": "Safety Rules",
        "image": ""
    },
    {
        "question": "The maximum speed in urban areas is usually:",
        "optionA": "80 km/h",
        "optionB": "50 km/h",
        "optionC": "100 km/h",
        "optionD": "30 km/h",
        "correctAnswer": "B",
        "explanation": "Maximum speed in urban areas is usually 50 km/h unless posted otherwise.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Before driving, you should check:",
        "optionA": "Brakes",
        "optionB": "Lights",
        "optionC": "Mirrors and fuel",
        "optionD": "All of the above",
        "correctAnswer": "D",
        "explanation": "Check brakes, lights, mirrors, fuel, and seat position.",
        "category": "Safety Rules",
        "image": ""
    },
    {
        "question": "What does a yellow traffic light mean?",
        "optionA": "Go immediately",
        "optionB": "Prepare to stop",
        "optionC": "Stop immediately",
        "optionD": "Speed up",
        "correctAnswer": "B",
        "explanation": "Yellow means slow down and prepare to stop.",
        "category": "Traffic Signals",
        "image": ""
    },
    {
        "question": "When can you overtake another vehicle?",
        "optionA": "Anywhere",
        "optionB": "On solid line",
        "optionC": "On broken line where safe",
        "optionD": "Never",
        "correctAnswer": "C",
        "explanation": "Overtake only where it is safe and permitted.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Alcohol and driving is:",
        "optionA": "Allowed in small quantity",
        "optionB": "Strictly prohibited",
        "optionC": "Allowed on highways",
        "optionD": "Allowed only at night",
        "correctAnswer": "B",
        "explanation": "Drinking and driving is strictly prohibited.",
        "category": "Safety Rules",
        "image": ""
    },
    {
        "question": "Overloading passengers in a car is:",
        "optionA": "Allowed",
        "optionB": "Prohibited",
        "optionC": "Allowed with seat belts",
        "optionD": "Optional",
        "correctAnswer": "B",
        "explanation": "Overloading is prohibited for safety reasons.",
        "category": "Safety Rules",
        "image": ""
    },
    {
        "question": "What is the correct side for overtaking?",
        "optionA": "Left side",
        "optionB": "Right side",
        "optionC": "Either side",
        "optionD": "Middle lane",
        "correctAnswer": "B",
        "explanation": "Overtake from the right side only.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "When approaching a roundabout, you must:",
        "optionA": "Speed up",
        "optionB": "Yield to traffic in roundabout",
        "optionC": "Honk continuously",
        "optionD": "Enter immediately",
        "correctAnswer": "B",
        "explanation": "Give way to vehicles already in the roundabout.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "Use of indicators is mandatory when:",
        "optionA": "Turning or changing lanes",
        "optionB": "Driving straight",
        "optionC": "Stopping",
        "optionD": "Only at night",
        "correctAnswer": "A",
        "explanation": "Always use indicators when turning or changing lanes.",
        "category": "Traffic Rules",
        "image": ""
    },
    {
        "question": "You see a pedestrian crossing sign. You should:",
        "optionA": "Stop immediately",
        "optionB": "Ignore it",
        "optionC": "Slow down and watch for pedestrians",
        "optionD": "Honk and pass",
        "correctAnswer": "C",
        "explanation": "Slow down and be prepared to stop for pedestrians.",
        "category": "Traffic Signs",
        "image": ""
    },
    {
        "question": "No Entry sign indicates:",
        "optionA": "Entry is allowed",
        "optionB": "Vehicles are prohibited from entering",
        "optionC": "Stop only",
        "optionD": "Slow down",
        "correctAnswer": "B",
        "explanation": "Vehicles must not enter roads marked with No Entry sign.",
        "category": "Traffic Signs",
        "image": "https://upload.wikimedia.org/wikipedia/commons/f/f7/No_entry_sign.svg"
    },
    {
        "question": "What is the purpose of a yield (give way) sign?",
        "optionA": "Stop completely",
        "optionB": "Slow down and give way if needed",
        "optionC": "Accelerate",
        "optionD": "Ignore",
        "correctAnswer": "B",
        "explanation": "Yield to other traffic when necessary.",
        "category": "Traffic Signs",
        "image": "https://upload.wikimedia.org/wikipedia/commons/3/33/Yield_sign.svg"
    }
]

questions_collection.insert_many(questions)
print("✅ 20 Punjab driving test questions inserted!")