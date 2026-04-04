# chapter_v_mongodb.py

from pymongo import MongoClient

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")  # Adjust if using Atlas
db = client["driving_test"]
collection = db["rule_book"]

# Chapter V data structured as nested dictionaries and lists
chapter_v = {
    "chapter": 5,
    "title": "N.-W.F.P. Road Transport Board",
    "sections": [
        {
            "section": 70,
            "title": "Establishment and composition of the Board",
            "subsections": {
                "1": "Government may establish a N.-W.F.P. Road Transport Board for operating road transport services in the Province. The Board shall be a body corporate with perpetual succession and a common seal, and may sue or be sued in its name.",
                "2": "The Board shall consist of a Chairman and such number of members as may be appointed by the Government.",
                "3": "Term of office of Chairman or members shall be three years. If a person is in the service of Pakistan, the term shall be determined by Government.",
                "4": "Upon expiry, the Chairman or member may be re-appointed for another term or a shorter term as determined by Government.",
                "5": "Chairman or any member may resign at any time; resignation takes effect only upon acceptance by Government.",
                "6": "Chairman and members shall receive salary and allowances as determined by Government and perform duties assigned under the Ordinance or rules.",
                "7": {
                    "i": "Government may remove Chairman or member if they refuse/fail to discharge responsibilities or are incapable of doing so.",
                    "ii": "If declared insolvent.",
                    "iii": "If disqualified or dismissed from Federal or Provincial service, or convicted of an offence involving moral turpitude.",
                    "iv": "If they knowingly hold a share or interest in contracts, employment, or property benefiting from the Board without written permission."
                },
                "7a": "Any person employed for purposes of the Board shall be deemed a public servant within the meaning of Section 21 of Pakistan Penal Code.",
                "8": "Government shall consult the Board on coordination of road and rail transport, and in fixation of areas and freights under Chapter IV.",
                "9": "Government may make rules prescribing powers and functions of the Board, consistent with the Ordinance."
            }
        },
        {
            "section": 71,
            "title": "Transport authorities to have no jurisdiction in respect of motor transport operated by the Board",
            "subsections": {
                "1": "The Board may operate motor transport on any route it deems fit; Provincial or Regional Transport Authorities have no jurisdiction over such transport.",
                "2": "Provincial or Regional Transport Authorities shall not grant stage carriage permits on new urban routes unless an offer has been made to the Board and the Board declines within three months."
            }
        },
        {
            "section": 72,
            "title": "Power of the Board to acquire property for motor transport",
            "subsections": {
                "1": "The Board may acquire movable or immovable property used for motor transport under this chapter.",
                "2": "Acquisition may be effected by serving notice to the owner, or by notice in the official Gazette if owner is untraceable or ownership is disputed. It takes effect from the date of notice.",
                "3": "Compensation equivalent to market value of acquired property shall be paid, as prescribed by Government.",
                "4": "Disputes regarding compensation shall be referred to arbitration by a person who is or has been a High Court Judge; the award shall be final and binding and not subject to any court or the Arbitration Act, 1940."
            }
        }
    ]
}

# Insert document into MongoDB
result = collection.insert_one(chapter_v)
print(f"Chapter V inserted with ID: {result.inserted_id}")