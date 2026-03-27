import pdfplumber
from pymongo import MongoClient

# 1. Load PDF
pdf_path = "rules.pdf"
full_text = ""

with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        text = page.extract_text()
        if text:
            full_text += text + "\n"

print("PDF Loaded Successfully")

# 2. Parse into sections
sections = []
current_section = None

for line in full_text.split("\n"):
    line = line.strip()

    if not line:
        continue

    # Better heading detection
    if ":" in line or line.istitle():
        current_section = {
            "title": line,
            "content": []
        }
        sections.append(current_section)
    else:
        if current_section:
            current_section["content"].append(line) # preview

# 3. Connect MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client["driving_test"]

# 4. Insert into DB
db.rules.delete_many({})  # optional clear old data
db.rules.insert_many(sections)

print("Inserted into MongoDB successfully!")