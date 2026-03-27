# chapter_iv_mongodb.py

from pymongo import MongoClient

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")  # Adjust if using Atlas
db = client["punjab_driving_test"]
collection = db["rule_book"]

# Chapter IV data structured as nested dictionaries and lists
chapter_iv = {
    "chapter": "IV",
    "title": "Control of Transport Vehicles",
    "sections": [
        {
            "section": 44,
            "title": "Transport vehicles not to be used or driven without permit",
            "subsections": {
                "1": "No owner of a transport vehicle shall use or permit the use of, and no driver of a transport vehicle shall drive or cause or permit to be driven, the vehicle in any public place, save in accordance with the conditions of a permit authorising the use or driving of the vehicle in such place granted or countersigned by a Regional or Provincial Transport Authority. Provisions regarding stage carriage and public carrier permits are included.",
                "2": [
                    "Delivery or collection of goods by or on behalf of the owner for purposes other than transport business is not deemed carriage for hire or reward.",
                    "Temporary ownership for transportation to another place constitutes carriage for hire or reward."
                ],
                "3": [
                    "Exceptions where subsection (1) does not apply:",
                    "Transport vehicle owned by Federal or Provincial Government for public purposes.",
                    "Vehicles owned by local authorities for road cleaning, watering, or conservancy.",
                    "Emergency vehicles, vehicles for prescribed public purposes, vehicles for transporting corpses, towing vehicles, school buses, and certain trailers."
                ],
                "4": "Government may extend subsection (1) to motor vehicles adapted to carry more than nine passengers, subject to rules."
            }
        },
        {
            "section": "44-A",
            "title": "Permission to drive transport vehicle registered in other Province",
            "subsections": {
                "a": "Transport vehicles with permits issued by Provincial Transport Authority may be allowed within the Province.",
                "b": "Other vehicles may be allowed by general or special order of the Government, subject to terms."
            }
        },
        {
            "section": 45,
            "title": "Power of Government to control road transport",
            "subsections": {
                "1": [
                    "Government may prohibit or restrict long-distance goods traffic.",
                    "Government may fix maximum or minimum fares or freights for stage carriages and public carriers."
                ],
                "2": "Government may cancel permits for specific routes to allow Board's vehicles.",
                "3": "Government may direct authorities to restrict or not issue permits on certain routes."
            }
        },
        {
            "section": 46,
            "title": "Transport Authorities",
            "subsections": {
                "1": "Government shall constitute Provincial and Regional Transport Authorities.",
                "2": "Composition rules and financial interest restrictions.",
                "5": "Violation of interest rules deemed an offence.",
                "6": [
                    "Powers of Provincial Transport Authority include coordinating Regional Authorities, settling disputes, issuing orders, and delegating powers."
                ]
            }
        },
        {
            "section": 47,
            "title": "General provisions as to applications for permit",
            "subsections": {
                "1": "Applications made to the Regional Transport Authority of the region of intended use or residence.",
                "2": "Exceptions for Board-operated road transport services."
            }
        },
        {
            "section": 48,
            "title": "Application for stage carriage permits",
            "subsections": {
                "1": [
                    "Applicant's name and address.",
                    "Vehicle registration, type, model, seating capacity.",
                    "Route or area of operation.",
                    "Other prescribed matters."
                ],
                "2": "Affidavit confirming applicant is actual owner."
            }
        },
        {
            "section": 49,
            "title": "Procedure for grant of applications for stage carriage permits",
            "subsections": {
                "1": [
                    "Granting permit on payment of fee and bank guarantee for compensation.",
                    "Refusal in case of suspension or cancellation of previous permit."
                ],
                "2": "Exemption from bank guarantee for urban stage carriage permit or if member of Transporter's Mutual Assistance Cooperative Society."
            }
        },
        {
            "section": 50,
            "title": "Conditions for grant of stage carriage permits",
            "subsections": {
                "1": "Compensation amounts for death or injury of passengers.",
                "2": [
                    "Prescribed conditions may include:",
                    "Service commencement date and duration",
                    "Number of return trips",
                    "Specified routes/areas",
                    "Fare and timetable display",
                    "Passenger and luggage limits",
                    "Designated boarding/alighting places",
                    "Maintenance of accounts and records",
                    "Ticket issuance"
                ]
            }
        },
        {
            "section": 51,
            "title": "Application for contract carriage permits",
            "subsections": {
                "1": [
                    "Applicant's name and address",
                    "Vehicle type and seating capacity",
                    "Area of operation",
                    "Other prescribed particulars"
                ]
            }
        },
        {
            "section": 52,
            "title": "Procedure of Regional Transport Authority in considering application for contract carriage permits",
            "subsections": {
                "1": "Consider public interest, existing permit holders, and authorities’ input."
            }
        },
        {
            "section": 53,
            "title": "Power to restrict the number of contract carriage and impose conditions on contract carriage permits",
            "subsections": {
                "1": [
                    "Fix number of contract carriages",
                    "Grant or refuse permits based on rules",
                    "Attach conditions regarding areas, routes, goods, fares, weights, taxi meters, and variations"
                ],
                "2": "Condition for compensation in case of death or injury to passenger."
            }
        },
        {
            "section": 54,
            "title": "Application for private carriers permits",
            "subsections": {
                "1": [
                    "Vehicle type and carrying capacity",
                    "Nature of goods",
                    "Area for permit",
                    "Other prescribed particulars"
                ]
            }
        },
        {
            "section": 55,
            "title": "Procedure of regional transport authority in considering application for a private carrier’s permits",
            "subsections": {
                "1": [
                    "Grant permit if vehicle used for applicant's business, not transport business",
                    "May refuse if previous permit suspended or canceled",
                    "May impose conditions on goods, area, max weight"
                ],
                "2": "Extension of permit operation within or outside region."
            }
        },
        {
            "section": 56,
            "title": "Application for public carrier’s permit",
            "subsections": {
                "1": "Application to contain prescribed particulars."
            }
        },
        {
            "section": 57,
            "title": "Procedure of regional transport authority in considering application for a public carrier’s permit",
            "subsections": {
                "1": [
                    "Grant permit on payment of fees",
                    "May refuse if applicant’s previous permit canceled/suspended"
                ],
                "2": "Extension of permit within or outside region."
            }
        },
        {
            "section": 58,
            "title": "Power to restrict the number of and attach conditions to public carriers permits",
            "subsections": {
                "1": [
                    "Use on specified routes or area",
                    "Max laden and axle weights",
                    "Maintain prescribed records",
                    "Other specified conditions for public interest or to prevent uneconomic competition"
                ]
            }
        },
        {
            "section": 59,
            "title": "Procedure in applying for and granting permit",
            "subsections": {
                "1": "Application can be made at any time",
                "7": "Reasons for refusal must be given in writing"
            }
        },
        {
            "section": 60,
            "title": "Duration and renewal of permit",
            "subsections": {
                "1": [
                    "Stage or contract carriage permit: 1-3 years",
                    "Other permits: 3-5 years"
                ],
                "2": "Permit may be renewed on application and fee."
            }
        },
        {
            "section": 61,
            "title": "General condition attaching to all permits",
            "subsections": {
                "1": "Permit not transferable without permission",
                "2": "Vehicle may be replaced with similar vehicle",
                "3-5": "Conditions: maintenance, speed limit, observe fares, laws, insurance, business premises"
            }
        },
        {
            "section": 62,
            "title": "Cancellation and suspension of permit",
            "subsections": {
                "1": [
                    "Permit may be canceled/suspended for breach of conditions, unauthorized use, loss of vehicle, fraud, subversive activities, banned goods, forgery",
                    "Opportunity for explanation must be given"
                ],
                "2": "Written reasons to be recorded and copy given to holder"
            }
        },
        {
            "section": 63,
            "title": "Transfer of permission on death of holders",
            "subsections": {
                "1": "Successor may use permit for 3 months, must notify authority",
                "2": "Transport authority may transfer permit within 3 months on application"
            }
        },
        {
            "section": 64,
            "title": "Special permits",
            "subsections": {
                "1": "Permit for one return trip as public-service vehicle",
                "2": "Authority may delegate powers to issue special permits"
            }
        },
        {
            "section": 66,
            "title": "Appeals",
            "subsections": {
                "1": [
                    "Aggrieved by refusal, cancellation, variation, countersignature, renewal, or local authority objection",
                    "May appeal within 30 days",
                    "Appellate authority cannot increase permits granted",
                    "No appeal against sec 45(2)",
                    "No court jurisdiction except as provided"
                ]
            }
        }
    ]
}

# Insert document into MongoDB
result = collection.insert_one(chapter_iv)
print(f"Chapter IV inserted with ID: {result.inserted_id}") 