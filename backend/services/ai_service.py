import requests

LM_STUDIO_URL = "http://localhost:1234/v1/chat/completions"

def get_ai_suggestion(user_data):
    prompt = f"""
You are a driving instructor AI.

User stats:
XP: {user_data['xp']}
Streak: {user_data['streak']}
Progress: {user_data['progress']}

Weak areas:
{user_data['weak_topics']}

Wrong answers:
{user_data['wrong_answers']}

Task:
Give personalized driving learning advice.
- Tell what to improve
- Suggest what to study next
- Keep it short and practical
"""

    response = requests.post(
        LM_STUDIO_URL,
        json={
            "model": "phi-3-mini",
            "messages": [
                {"role": "system", "content": "You are a helpful driving coach."},
                {"role": "user", "content": prompt}
            ],
            "temperature": 0.7
        }
    )

    return response.json()["choices"][0]["message"]["content"]