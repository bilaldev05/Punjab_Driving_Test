from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes import (
    users,
    questions,
    results,
    exam,
    analytics,
    signs,
    admin
)

app = FastAPI(title="Punjab Driving Test API")

# -----------------------------
# CORS CONFIGURATION
# -----------------------------

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://127.0.0.1:8000",
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,      # allowed origins
    allow_credentials=True,
    allow_methods=["*"],        # allow all methods
    allow_headers=["*"],        # allow all headers
)

# -----------------------------
# ROUTERS
# -----------------------------

app.include_router(users.router)
app.include_router(questions.router)
app.include_router(results.router)
app.include_router(exam.router)
app.include_router(analytics.router)
app.include_router(signs.router)
app.include_router(admin.router)


# -----------------------------
# ROOT
# -----------------------------

@app.get("/")
def home():
    return {"message": "Punjab Driving Test API running"}


    # python -m uvicorn main:app --reload 