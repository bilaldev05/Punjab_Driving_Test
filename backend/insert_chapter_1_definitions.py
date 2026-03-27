# insert_chapter_1_definitions.py

from pymongo import MongoClient

# --------------------------
# MongoDB Connection
# --------------------------
client = MongoClient("mongodb://localhost:27017/")  # Adjust if using Atlas
db = client["punjab_driving_test"]
collection = db["rule_book"]

# --------------------------
# Chapter I: Preliminary Definitions
# --------------------------
chapter_1_definitions = {
    "chapter_number": 1,
    "title": "CHAPTER-I: PRELIMINARY",
    "sections": [
        "Short title and extent: This Ordinance may be called the Provincial Motor Vehicle Ordinance, 1965. It extends to the whole of Pakistan.",
        "Definitions: Unless the context otherwise requires, the following expressions shall have the meanings hereby respectively assigned:",
        "1. 'ambulance' means a vehicle designed for the carriage of sick, wounded or invalid persons or animals.",
        "2. 'axle weight' means in relation to an axle of a vehicle the total weight transmitted by the several wheels attached to that axle to the surface on which the vehicle rests.",
        "3. 'Board' means the North West Frontier Province Road Transport Board established under section 70.",
        "4. 'certificate of registration' means the certificate issued by a competent authority to the effect that a motor vehicle has been duly registered in accordance with the provisions of Chapter-III.",
        "5. 'contract carriage' means a motor vehicle which carries passengers for hire or reward under a contract for use of the vehicle as a whole and includes a motor cab.",
        "6. 'delivery van' means any goods vehicle the registered laden weight of which does not exceed 5,000 pounds avoirdupois.",
        "7. 'driver' includes any person engaged in driving a motor vehicle.",
        "8. 'emergency vehicle' means a motor vehicle used solely for police, fire-brigade, ambulance, or to relieve distress.",
        "9. 'fares' includes sums payable for a season ticket or hire of a contract carriage.",
        "10. 'goods' include livestock and anything carried by a vehicle except living persons and luggage.",
        "11. 'goods vehicle' means any motor vehicle constructed or adapted for the carriage of goods or used for goods carriage solely or in addition to passengers.",
        "12. 'Government' means the Provincial Government.",
        "13. 'heavy transport vehicle' means a transport vehicle with registered axle weight > 10,600 pounds or laden weight > 14,500 pounds.",
        "14. 'intersection' includes the area bounded by side lines of two or more public highways which meet or cross each other.",
        "15. 'invalid carriage' means a motor vehicle specially designed for a person suffering from a physical defect or disability, unladen weight ≤ 500 pounds.",
        "16. 'licence' means the document issued by a competent authority authorising a person to drive a motor vehicle.",
        "17. 'licensing authority' means an authority empowered to grant licences under this ordinance.",
        "18. 'light transport vehicle' means any public service vehicle other than a motor cab, or any goods vehicle other than a heavy transport vehicle or delivery van.",
        "19. 'locomotive' means a motor vehicle not constructed to carry any load (other than propulsion equipment), unladen weight > 16,000 pounds, excluding road rollers.",
        "20. 'motor cab' means a motor vehicle carrying ≤10 passengers excluding the driver for hire or reward.",
        "21. 'motor car' means any motor vehicle other than a transport vehicle, locomotive, road roller, tractor, motorcycle or invalid carriage.",
        "22. 'motor cycle' means a motor vehicle, other than an invalid carriage, with <4 wheels, unladen weight ≤900 pounds including side-car.",
        "23. 'motor vehicle' means any mechanically propelled vehicle adapted for use on roads, includes chassis, tractor, and trailer, but excludes vehicles running on fixed rails or used solely on owner premises.",
        "24. 'Owner' means the person in whose name the motor vehicle is registered, or in case of hire-purchase, the person in possession; includes guardian of minor, company directors, society principal officer, partners of firm, or nominated member of association.",
        "25. 'permit' means the document issued by the Provincial or Regional Transport Authority authorising use of a transport vehicle as a contract carriage, stage carriage, private or public carrier.",
        "26. 'prescribed' means prescribed by rules made under this Ordinance.",
        "27. 'private carrier' means an owner of a transport vehicle who uses it solely for goods of his property or necessary for his business, excluding transport as a service.",
        "27-A. 'Province' means the North-West Frontier Province.",
        "28. 'public carrier' means an owner of a transport vehicle who transports goods for another for hire or reward and includes any engaged person or company.",
        "29. 'public highway' includes any highway, road, street, avenue, alley, public place, driveway, or other public way.",
        "30. 'public place' means a road, street, or other place to which the public has a right of access, including stage carriage stands.",
        "31. 'public service vehicle' means any motor vehicle used or adapted for carriage of passengers for hire or reward, including motor cab, contract carriage, and stage carriage.",
        "32. 'registered axle weight' means the axle weight certified and registered by the authority as permissible for that vehicle.",
        "33. 'registered laden weight' means total weight of the vehicle and load certified and registered as permissible.",
        "34. 'registering authority' means an authority empowered to register motor vehicles under Chapter III.",
        "35. 'school bus' means any motor vehicle used exclusively for carriage of students of recognised educational institutions.",
        "36. 'semi-trailer' means a vehicle designed so that its forward end rests on the towing motor vehicle.",
        "37. 'stage carriage' means a motor vehicle carrying >6 persons excluding driver, for hire or reward, paid by individual passengers for whole or stage journey.",
        "38. 'street (roadway)' means that part of public highway intended for vehicular traffic.",
        "39. 'tractor' means a motor vehicle not constructed to carry any load (other than propulsion), unladen weight ≤16,000 pounds, excluding road rollers.",
        "40. 'traffic signs' includes all signals, warning posts, direction posts or devices for information, guidance, or direction of drivers.",
        "41. 'trailer' means any vehicle other than a side-car drawn or intended to be drawn by a motor vehicle.",
        "42. 'transport vehicle' means a public service vehicle, goods vehicle, locomotive, or tractor.",
        "43. 'unladen weight' means the weight of a vehicle including all equipment ordinarily used but excluding driver and attendants; for alternative parts, the heaviest configuration applies.",
        "44. 'weight' means total weight transmitted by the wheels of a vehicle to the surface on which it rests."
    ]
}

# --------------------------
# Insert into MongoDB
# --------------------------
collection.update_one(
    {"chapter_number": chapter_1_definitions["chapter_number"]},
    {"$set": chapter_1_definitions},
    upsert=True
)

print("Chapter I Definitions inserted successfully!")