# routes/rulebook.py
from fastapi import APIRouter
from fastapi.responses import StreamingResponse
import os

router = APIRouter(prefix="/rulebook", tags=["Rule Book"])

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PDF_PATH = os.path.join(BASE_DIR, "../assets/pdfs/rulebook.pdf")

@router.get("/pdf")
def get_rulebook_pdf():
    if os.path.exists(PDF_PATH):
        file = open(PDF_PATH, "rb")
        return StreamingResponse(file, media_type="application/pdf")
    return {"error": "PDF not found"}