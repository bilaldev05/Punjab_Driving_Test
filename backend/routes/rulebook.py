from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse, StreamingResponse
import os

router = APIRouter(prefix="/rulebook", tags=["Rule Book"])

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PDF_PATH = os.path.join(BASE_DIR, "../assets/pdfs/rulebook.pdf")


# ✅ 1. VIEW PDF (INLINE - for iframe)
@router.get("/view")
def view_rulebook():
    if not os.path.exists(PDF_PATH):
        raise HTTPException(status_code=404, detail="PDF not found")

    return FileResponse(
        PDF_PATH,
        media_type="application/pdf",
        filename="rulebook.pdf",
        headers={
            "Content-Disposition": "inline",
            "Cache-Control": "public, max-age=86400",  # cache 1 day
        },
    )


# ✅ 2. DOWNLOAD PDF
@router.get("/download")
def download_rulebook():
    if not os.path.exists(PDF_PATH):
        raise HTTPException(status_code=404, detail="PDF not found")

    return FileResponse(
        PDF_PATH,
        media_type="application/pdf",
        filename="rulebook.pdf",
        headers={
            "Content-Disposition": "attachment",
        },
    )


#  3. STREAM PDF (for large files / advanced viewers)
@router.get("/stream")
def stream_rulebook():
    if not os.path.exists(PDF_PATH):
        raise HTTPException(status_code=404, detail="PDF not found")

    def iterfile():
        with open(PDF_PATH, "rb") as file:
            yield from file

    return StreamingResponse(
        iterfile(),
        media_type="application/pdf",
        headers={
            "Content-Disposition": "inline",
        },
    )


# ✅ 4. METADATA (for UI)
@router.get("/info")
def rulebook_info():
    if not os.path.exists(PDF_PATH):
        raise HTTPException(status_code=404, detail="PDF not found")

    file_size = os.path.getsize(PDF_PATH)

    return {
        "name": "Punjab Driving Rule Book",
        "size_kb": round(file_size / 1024, 2),
        "pages": "Unknown (can add later)",
        "version": "2026",
    }