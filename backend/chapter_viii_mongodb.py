# chapter_v_mongodb.py

from pymongo import MongoClient

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")  # Adjust if using Atlas
db = client["punjab_driving_test"]
collection = db["rule_book"]

# Chapter V data structured as nested dictionaries and lists
chapter_viii = {
  "chapter": "VIII",
  "title": "Offences, Penalties and Procedure",
  "sections": [
    {
      "section_no": 97,
      "title": "Offences relating to licenses",
      "content": "Whoever, being disqualified under this Ordinance for holding or obtaining a licence, drives a motor vehicle in a public place or applies for or obtains a licence or, not being entitled to have a licence issued to him free of endorsement, applies for or obtains a licence without disclosing the endorsements made on a licence previously held by him...",
      "penalty": {
        "general": "Imprisonment up to 6 months or fine up to 500 rupees or both",
        "transport_vehicle": "Imprisonment up to 2 years and fine up to 1000 rupees"
      }
    },
    {
      "section_no": 98,
      "title": "Driving at excessive speed",
      "subsections": [
        {
          "subsection_no": 1,
          "content": "Whoever drives a motor vehicle in contravention of section 75...",
          "penalty": {
            "general": "Fine up to 100 rupees",
            "transport_vehicle": "Fine 100-500 rupees"
          }
        },
        {
          "subsection_no": 2,
          "content": "Whoever causes any person employed by him to drive a motor vehicle in contravention of section 75...",
          "penalty": {
            "general": "Fine up to 200 rupees",
            "transport_vehicle": "Fine up to 500 rupees"
          }
        },
        {
          "subsection_no": 3,
          "content": "No person shall be convicted solely on opinion of one witness unless opinion is based on mechanical device"
        },
        {
          "subsection_no": 4,
          "content": "Publication of timetable or direction that requires unlawful speed is prima facie evidence of offence"
        }
      ]
    },
    {
      "section_no": 99,
      "title": "Driving recklessly or dangerously",
      "subsections": [
        {
          "subsection_no": 1,
          "content": "Whoever drives a motor vehicle at a speed or in a manner which is dangerous to human life or property...",
          "penalty": {
            "general": "Imprisonment up to 6 months or fine up to 500 rupees",
            "transport_vehicle": "Imprisonment up to 1 year and fine up to 1000 rupees"
          }
        },
        {
          "subsection_no": 2,
          "content": "Subsequent offence within 3 years after conviction",
          "penalty": {
            "general": "Imprisonment up to 2 years or fine up to 1000 rupees",
            "transport_vehicle": "Imprisonment up to 4 years and fine up to 1000 rupees"
          }
        }
      ]
    },
    {
      "section_no": 100,
      "title": "Driving while under the influence of drink or drugs",
      "content": "Whoever while driving or attempting to drive is under the influence of drink or drugs...",
      "penalty": {
        "first_offence": "Imprisonment up to 6 months or fine up to 1000 rupees",
        "subsequent_offence": "Imprisonment up to 2 years or fine up to 1000 rupees"
      }
    },
    {
      "section_no": 101,
      "title": "Driving when mentally or physically unfit to drive",
      "content": "Whoever drives a motor vehicle when suffering from disease or disability...",
      "penalty": {
        "first_offence": "Fine up to 200 rupees",
        "subsequent_offence": "Fine up to 500 rupees"
      }
    },
    {
      "section_no": 102,
      "title": "Punishment for abetment of certain offences",
      "content": "Whoever abets the commission of an offence under section 99, 100 or 101 shall be punishable with the punishment provided for the offence."
    },
    {
      "section_no": 103,
      "title": "Racing and trials of speed",
      "content": "Whoever, without written consent of Government, takes part in a race or trial of speed...",
      "penalty": "Imprisonment up to 6 months or fine up to 1000 rupees or both"
    },
    {
      "section_no": 104,
      "title": "Using vehicle in unsafe condition",
      "content": "Any person who drives or allows a defective vehicle which may endanger persons...",
      "penalty": {
        "general": "Imprisonment up to 1 month or fine up to 500 rupees or both",
        "if accident occurs": "Imprisonment up to 6 months or fine up to 1000 rupees or both"
      }
    },
    {
      "section_no": 105,
      "title": "Sale or alteration of vehicle in contravention",
      "content": "Importer or dealer selling or altering vehicle so it contravenes rules...",
      "penalty": "Fine up to 200 rupees"
    },
    {
      "section_no": 106,
      "title": "Using vehicle without permit",
      "subsections": [
        {
          "subsection_no": 1,
          "content": "Whoever drives vehicle in contravention of permit provisions...",
          "penalty": {
            "first_offence": "Imprisonment up to 6 months or fine up to 500 rupees",
            "subsequent_offence": "Imprisonment up to 2 years or fine up to 1000 rupees or both"
          }
        },
        {
          "subsection_no": 2,
          "content": "Exceptions for emergency use with reporting to Regional Transport Authority within 7 days"
        }
      ]
    },
    {
      "section_no": 107,
      "title": "Driving vehicle in contravention of permit conditions",
      "penalty": {
        "first_offence": "Fine up to 100 rupees",
        "subsequent_offence": "Fine up to 500 rupees"
      }
    },
    {
      "section_no": 108,
      "title": "Driving vehicle exceeding permissible weight",
      "penalty": "Imprisonment up to 6 months or fine up to 1000 rupees or both"
    },
    {
      "section_no": 109,
      "title": "Taking vehicle without authority",
      "penalty": "Imprisonment up to 3 months or fine up to 500 rupees or both"
    },
    {
      "section_no": 110,
      "title": "Unauthorized interference with vehicle",
      "penalty": "Imprisonment up to 1 month or fine up to 200 rupees or both"
    },
    {
      "section_no": 111,
      "title": "Disobedience of orders, obstruction and refusal of information",
      "penalty": "Fine up to 200 rupees if no other penalty is provided"
    },
    {
      "section_no": 111.0, 
      "title": "Penalty for contravention of rules relating to appliances",
      "penalty": "Fine up to 500 rupees; appliance forfeited to Government"
    },
    {
      "section_no": 112,
      "title": "General provision for punishment of offences not otherwise provided",
      "penalty": {
        "first_offence": "Fine up to 100 rupees",
        "subsequent_offence": "Fine up to 500 rupees"
      }
    },
    {
      "section_no": 113,
      "title": "Power of arrest without warrant",
      "subsections": [
        {
          "subsection_no": 1,
          "content": "Police officer in uniform may arrest without warrant for offences under section 99, 100 or 110; medical examination within 2 hours for section 100"
        },
        {
          "subsection_no": 2,
          "content": "Police may arrest anyone refusing to give name/address or reasonably suspected to abscond"
        },
        {
          "subsection_no": 3,
          "content": "Police shall take steps for temporary disposal and safe custody of vehicle"
        }
      ]
    },
    {
      "section_no": 114,
      "title": "Power of police officer to seize documents",
      "subsections": [
        {
          "subsection_no": 1,
          "content": "Police may seize false documents on vehicles or licences"
        },
        {
          "subsection_no": 2,
          "content": "Police may seize licence if driver may abscond; licence returned upon appearance"
        },
        {
          "subsection_no": 3,
          "content": "Temporary acknowledgment authorises driving until licence returned"
        }
      ]
    },
    {
      "section_no": 115,
      "title": "Power to detain vehicle used without certificate of registration or permit"
    },
    {
      "section_no": 116,
      "title": "Summary disposal of cases",
      "subsections": [
        {
          "subsection_no": 1,
          "content": "Court may allow appearance by pleader or plea by registered letter with remittance"
        },
        {
          "subsection_no": 2,
          "content": "Special provisions for offences under Fifth Schedule"
        },
        {
          "subsection_no": 3,
          "content": "Police officer draws up charge for on-the-spot offences in specified form; offender pays fine to avoid further proceedings"
        }
      ]
    },
    {
      "section_no": 117,
      "title": "Restriction on conviction",
      "content": "No person prosecuted under section 99 or 100 shall be convicted unless warned or notice/summons served within specified timeframes"
    },
    {
      "section_no": 118,
      "title": "Jurisdiction",
      "content": "No Court inferior to Magistrate of second class shall try any offence under this Ordinance"
    }
  ]
}
        

# Insert document into MongoDB
result = collection.insert_one(chapter_viii)
print(f"Chapter Viii inserted with ID: {result.inserted_id}")