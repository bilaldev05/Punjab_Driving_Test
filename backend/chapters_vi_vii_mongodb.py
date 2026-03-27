# chapters_vi_vii_mongodb.py

from pymongo import MongoClient

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")  # Adjust if using Atlas
db = client["punjab_driving_test"]
collection = db["rule_book"]

# Chapter VI: Construction, Equipment and Maintenance of Motor Vehicles
chapter_vi = {
    "chapter": "VI",
    "title": "Construction, Equipment and Maintenance of Motor Vehicles",
    "sections": [
        {
            "section": 73,
            "title": "General provision regarding construction and maintenance",
            "subsections": {
                "1": "Every motor vehicle shall be so constructed and maintained as to be at all times under the effective control of the persons driving the vehicles."
            }
        },
        {
            "section": 74,
            "title": "Power to make rules",
            "subsections": {
                "1": "Government may make rules regulating the construction, equipment and maintenance of motor vehicles and trailers.",
                "2": {
                    "description": "Without prejudice to the generality, Government may make rules governing the following matters:",
                    "points": {
                        "a": "Width, height, length and overhang of vehicle and load carried.",
                        "b": "Seating arrangement in public service vehicles and protection of passengers against weather.",
                        "c": "Size, nature and condition of tyres.",
                        "d": "Brakes and steering gear.",
                        "e": "Use of safety glass.",
                        "f": "Signalling appliances, lamps and reflectors.",
                        "g": "Speed governors.",
                        "h": "Emission of smoke, visible vapour, sparks, ashes, grit or oil.",
                        "i": "Reduction of noise emitted by vehicles.",
                        "j": "Prohibiting or restricting the use of audible signals at certain times or places.",
                        "k": "Prohibiting carrying of appliances likely to cause annoyance or danger.",
                        "l": "Periodical testing and inspection of vehicles by prescribed authorities.",
                        "m": "Particulars, other than registration marks, to be exhibited by vehicles.",
                        "n": "Use of trailers or semi-trailers with motor vehicles.",
                        "o": "Prohibiting or requiring painting of motor vehicles in particular colours, descriptions, purposes or areas."
                    }
                }
            }
        }
    ]
}

# Chapter VII: Control of Traffic
chapter_vii = {
    "chapter": "VII",
    "title": "Control of Traffic",
    "sections": [
        {
            "section": 75,
            "title": "Limits of speed",
            "subsections": {
                "1": "No person shall drive a motor vehicle exceeding the maximum speed fixed by this Ordinance or other laws. Maximum speed shall not exceed the limit in the Fight Schedule.",
                "2": "Government may restrict speed for public safety or road conditions and place traffic signs accordingly.",
                "3": "Section does not apply to vehicles registered under section 40 used for military manoeuvres during specified periods."
            }
        },
        {
            "section": 76,
            "title": "Limit of weight and limitation",
            "subsections": {
                "1": "Government may prescribe conditions for permits for heavy transport vehicles and may restrict their use in areas or routes.",
                "2": "Except as otherwise prescribed, no motor vehicle shall be driven without pneumatic tyres.",
                "3": {
                    "description": "No person shall drive a motor vehicle or trailer if:",
                    "points": {
                        "a": "Unladen weight exceeds that specified in the registration certificate.",
                        "b": "Laden weight exceeds registered laden weight.",
                        "c": "Any axle weight exceeds maximum axle weight specified."
                    }
                },
                "4": "If the driver is not the owner, the Court may presume the offence was committed with the owner's knowledge or orders."
            }
        },
        {
            "section": 77,
            "title": "Power to have vehicle weighed",
            "subsections": {
                "1": "Authorized person may require driver to take vehicle to a weighing device and direct further action if weight limits are exceeded."
            }
        },
        {
            "section": 78,
            "title": "Power to restrict the use of vehicles",
            "subsections": {
                "1": "Government may prohibit or restrict driving of vehicles or trailers in specific areas, roads, or bridges. Traffic signs shall be placed accordingly. Notification may be waived for restrictions ≤ 1 month."
            }
        },
        {
            "section": 79,
            "title": "Power to erect traffic signs",
            "subsections": {
                "1": "Government may place or permit traffic signs to regulate motor vehicle traffic.",
                "2": "Traffic signs for Ninth Schedule purposes shall follow size, color, type and may include transcriptions authorized by Government.",
                "3": "No new traffic signs shall be placed post-commencement except as allowed; prior signs deemed valid.",
                "4": "Government may remove signs or advertisements obscuring or misleading regarding traffic signs."
            }
        },
        {
            "section": 80,
            "title": "Parking places and halting station",
            "subsections": {
                "1": "Government may determine places where motor vehicles may stand and where public service vehicles may stop for longer periods."
            }
        },
        {
            "section": 81,
            "title": "Main roads",
            "subsections": {
                "1": "Government may designate roads as main roads via Gazette notification or traffic signs for regulations under Tenth Schedule."
            }
        },
        {
            "section": 82,
            "title": "Duty to obey traffic signs",
            "subsections": {
                "1": "Drivers must obey mandatory traffic signs and driving regulations in Tenth Schedule, and directions by electrical devices or police officers.",
                "2": "Mandatory traffic signs include Part III of Ninth Schedule or similar circular devices with red ground/border."
            }
        },
        {
            "section": 83,
            "title": "Signals and signaling devices",
            "subsections": {
                "1": "Driver shall make signals specified in Eleventh Schedule; signals may be mechanical or electrical devices affixed to vehicle."
            }
        },
        {
            "section": 84,
            "title": "Vehicles with left hand control",
            "subsections": {
                "1": "Left hand controlled vehicles must be equipped with prescribed mechanical or electrical signaling devices in working order."
            }
        },
        {
            "section": 85,
            "title": "Leaving vehicle in dangerous position",
            "subsections": {
                "1": "No vehicle shall remain at rest in a position or condition causing danger, obstruction, or inconvenience."
            }
        },
        {
            "section": 86,
            "title": "Riding on running boards",
            "subsections": {
                "1": "No person shall ride on running boards except as permitted by Government notifications for armed forces or police."
            }
        },
        {
            "section": 87,
            "title": "Obstruction of driver",
            "subsections": {
                "1": "No person shall stand, sit, or place anything that hampers driver's control."
            }
        },
        {
            "section": 88,
            "title": "Stationary vehicles",
            "subsections": {
                "1": "No vehicle may remain stationary unless driver is present, or brakes applied, or mechanism stopped to prevent motion."
            }
        },
        {
            "section": 89,
            "title": "Pillion riding",
            "subsections": {
                "1": "Two-wheeled motor cycle may carry only one additional person properly seated behind driver.",
                "1A": "Crash helmets mandatory for driver and pillion rider."
            }
        },
        {
            "section": 90,
            "title": "Duty to produce license and certificate of registration",
            "subsections": {
                "1": "Driver must produce licence, registration certificate, fitness certificate, and permits when demanded by police or Transport Department officer.",
                "2": "Owner or person in charge must produce certificate of registration and fitness certificate on demand.",
                "3": "If not in possession, must produce within 10 days at police station specified."
            }
        },
        {
            "section": 91,
            "title": "Railway crossing",
            "subsections": {
                "1": "Transport vehicle must stop before crossing unless authorized person walks ahead to clear railway lines.",
                "2": "Owner must report authorized person's details to Registration Authority.",
                "3": "Written authority of owner required for authorization."
            }
        },
        {
            "section": 92,
            "title": "Duty of driver to stop in certain cases",
            "subsections": {
                "1": "Driver must stop when instructed by police, animal handler, or in case of accident, and give name/address of self and owner to affected parties."
            }
        },
        {
            "section": 93,
            "title": "Duty of owner of motor vehicle to give information",
            "subsections": {
                "1": "Owner must provide information regarding driver’s name, address, and licence upon demand by police or Transport Department."
            }
        },
        {
            "section": 94,
            "title": "Duty of driver in case of accident and injury",
            "subsections": {
                "1": "Driver must take all reasonable steps to secure medical attention for injured persons, animals, and report property damage, and inform authorities within 24 hours."
            }
        },
        {
            "section": 95,
            "title": "Inspection of vehicle involved in accident",
            "subsections": {
                "1": "Authorized person may inspect and remove vehicle for examination; place of removal must be communicated and vehicle returned within 48 hours."
            }
        },
        {
            "section": 96,
            "title": "Power to make rules",
            "subsections": {
                "1": "Government may make rules to carry out provisions of this Chapter.",
                "2": {
                    "description": "Rules may cover:",
                    "points": {
                        "a": "Mechanical or electrical signalling devices.",
                        "b": "Erection of electrical signalling devices and types allowed.",
                        "c": "Removal and custody of broken-down or abandoned vehicles and loads.",
                        "d": "Installation and use of weighing devices.",
                        "e": "Exemption of emergency and special vehicles.",
                        "f": "Maintenance and management of parking places, stands, and fees.",
                        "g": "Prohibition of driving downhill with gear disengaged.",
                        "h": "Prohibition of mounting a moving vehicle.",
                        "i": "Prohibition of using footpaths by vehicles.",
                        "j": "Prevention of danger, injury, or obstruction to public, persons, or property."
                    }
                }
            }
        }
    ]
}

# Insert chapters into MongoDB
result_vi = collection.insert_one(chapter_vi)
result_vii = collection.insert_one(chapter_vii)

print(f"Chapter VI inserted with ID: {result_vi.inserted_id}")
print(f"Chapter VII inserted with ID: {result_vii.inserted_id}")