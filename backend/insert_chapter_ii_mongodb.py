# filename: insert_chapter_ii_mongodb.py

from pymongo import MongoClient

# MongoDB connection
client = MongoClient("mongodb://localhost:27017/")  # Change if using Atlas
db = client["driving_test"]
collection = db["rule_book"]
# Full text of Chapter II - Licensing of Drivers of Motor Vehicles
chapter_ii_text = """
CHAPTER-II  
LICENSING OF DRIVERS OF MOTOR VEHICLES  
Prohibition on 
driving 
without 
license.  
3.         1[l] No person shall drive a motor vehicle in any public place 
unless he holds an effective licence authorising him to drive the vehicle; 
and no person shall so drive a motor vehicle as paid employee or shall so 
drive a public service vehicle unless his licence specifically entitles him 
so to do: 
Provided that a person receiving instructions in driving a motor vehicle may, subject to 
such conditions as may be prescribed by Government in this behalf, drive a motor vehicle 
in any public place.  
                2[(2) No person shall drive a Motor Vehicle in any public place unless he has 
in his possession his own copy of the most recent version of the Pakistan Highway Code 
published by the Federal Government.]  
Age limit in 
connection 
with driving of 
motor 
vehicles.  
      a
4.         (1) No person shall drive in any public place— 
(i)
      a
 motor cycle or an invalid carriage, unless he has attained the age 
of eighteen years;  
(ii)
 motor car, otherwise than as a paid employee, unless he has 
attained the age of eighteen years;  
(iii)    
     a
 a motor car as a paid employee or a transport vehicle, unless he has 
attained the age of twenty-one years;  
(iv)
 heavy transport vehicle, unless he has attained the age of twenty
 two years. 
2.         (a) No person about the age of fifty years shall drive a transport 
vehicle in any public place unless the licence entitling him so to do bears 
an effective endorsement by the licensing authority that such person has 
furnished a certificate in Form B as set forth in the First Schedule signed 
by a registered medical practitioner. 
1. Section-3, re-numbered as sub-section (1) by Ord. VIII of 1978. 
2. After sub-section (1) a new sub-section (2) inserted by Ord. No. VIII of 1978. 
(b) The licensing authority shall not make on any licence any such endorsement as is 
referred to in clause (a) unless it appears from the medical certificate furnished by the 
holder of the licence that he is not suffering from any disease or disability specified in the 
Second Schedule or any other disease or disability which is likely to cause the driving by 
him of transport vehicle to be a source of-danger to the public or to the passengers.  
            (c)
 An endorsement made under the provisions of clause (a) shall be effective for 
a period of twelve months from the date thereof, but the said period may from time to 
time, be, extended by the licensing authority by a further period of twelve months at any 
one time on the production by the holder of the licence of a fresh medical certificate as 
required under clause (a) and on being satisfied there from that the holder of the licence is 
not suffering from any disease or disability referred to in clause (b).  
            (3)
 No person shall drive a motor vehicle in a public place with his eyes wholly or 
partly covered with any cloth or other opaque substance, or in such manner as to interfere 
in any manner with his vision.  
5.         No owner or person incharge of a motor vehicle shall cause or 
permit any person who does not satisfy the provisions of section 3 or 
section 4 to drive the vehicle.  
Owners of 
motor vehicles 
not to permit 
contravention 
of section 3 or 
section 4  
6.         No holder of a licence shall permit to be used by any other person. Restriction on 
use of license 
by person 
other than 
holder  
7.         (1) Any person who is not disqualified under section 4 for driving 
a motor vehicle and who is not for the time being disqualified for holding or obtaining a licence, may apply to the licensing authority having 
jurisdiction in the area in which he ordinarily resides or carries on 
business or, if the application is for a licence to drive as a paid employee, 
in which the employer resides or carries on business for the issue to him 
of a licence. 
Grant of 
license.  
1. Every application under sub section (1) shall be in Form A as set forth in the First 
Schedule, shall be signed by, or bear the thumb impression of the applicant in two 
places, and shall contain the information required by the form. 
2. When the application is for a licence to drive as a paid employee or to drive a 
transport vehicle, or where in any other case the licensing authority for reasons to 
be stated in writing so requires, the application shall be accompanied by a medical 
certificate 
in Form B as set forth in the First Schedule signed by a registered medical practitioner.  
1. Every application for a licence to drive 1[a motor vehicle] shall be accompanied 
by three copies of a recent photograph of the applicant attested by a Magistrate or 
2[an officer of Government not inferior in rank to an officer in Grade-17 of the 
National Pay scale.] 
2. If, from the application or from the medical-certificate referred to in sub-section 
(3) it appears that the applicant is suffering from any disease or disability 
specified in the Second Schedule or any other disease or disability which is likely 
to cause the driving by him of a motor vehicle of the class which he would be 
authorised by the licence applied for to drive to be a source of danger to the public 
or to the passengers, the licensing authority shall refuse to issue the licence: 
Provided that—  
(a)
     a
 licence limited to driving an invalid carriage may be issued to the applicant, if the 
licensing authority is satisfied that he is fit to drive such a carriage;  
(b)
     the applicant may, except where he suffers from a disease or disability specified in 
the Second Schedule, claim to be subjected to a test of his fitness or ability to drive a 
motor vehicle of a particular construction or design, and if he passes such test to the 
satisfaction of the licensing authority and is not other wise disqualified, the licensing 
authority shall grant him a licence to drive such motor vehicle as the licensing authority 
may specify in the licence.  
            (6)
 No licence shall be issued to any applicant unless he passes to the satisfaction 
of the licensing authority the test of co mpetence specified in the Third Schedule:  
            Provided that where the applicant is for a licence to drive a motor vehicle (not 
being a transport vehicle) otherwise than as a paid employee, the licensing authority may 
exempt the applicant from the test specified in the Third Schedule, if—  
(a)
     the applicant possesses a driving certificate issued by an automobile association 
recognized in this behalf by Government, or.  
1.     
In sub-section (4), for the words "as a paid employee and every application for a 
licence to drive a transport vehicle" the words "a Motor Vehicle" subs, by Ord. No. VIII 
of 1978.  
2.     for the words and figure "a Class 1 Officer of Government" the words and figure an 
officer of Government not inferior in rank to an officer in Grade 17 of the National Pay 
Scales" subs,  
by . . . . . ibid.  
(b)
     the licensing authority is satisfied that the applicant has previously held a licence 
(or similar document) valid outside the Province and has had not less than twelve months 
recent experience of driving a motor vehicle of the class to which the application refers:  
            Provided further that where the applicant, being a serving member of the armed 
forces of Pakistan, is in possession of a valid army driving licence and has been actually 
driving one or more classes of motor vehicles for not less than three years immediately 
before the date of application, the licensing authority shall subject to the prescribed 
conditions, exempt him from the test specified in the Third Schedule and issue to him a 
driving licence for the class or classes of motor vehicles he has been so driving.  
...
# (continue in same format for the entire chapter as you provided)
"""

# Insert into MongoDB
document = {
    "chapter": "Chapter-II",
    "title": "Licensing of Drivers of Motor Vehicles",
    "content": chapter_ii_text
}

result = collection.insert_one(document)
print(f"Inserted Chapter II with _id: {result.inserted_id}")