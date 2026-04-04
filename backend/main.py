from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes import (
    rulebook,
    users,
    questions,
    results,
    exam,
   
    signs,
    
)



app = FastAPI(title="Punjab Driving Test API")


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # for testing allow all
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -----------------------------
# ROUTERS
# -----------------------------

app.include_router(users.router)
app.include_router(questions.router)
app.include_router(results.router)
app.include_router(exam.router)

app.include_router(signs.router)

app.include_router(rulebook.router)


# -----------------------------
# ROOT
# -----------------------------

@app.get("/")
def home():
    return {"message": "Punjab Driving Test API running"}


    # python -m uvicorn main:app --reload 