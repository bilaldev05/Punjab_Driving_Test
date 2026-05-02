# services/ai_helper.py

def extract_weak_topics(mistakes):
    topics = {}

    for m in mistakes:
        topic = m.get("topic", "general")
        topics[topic] = topics.get(topic, 0) + 1

    sorted_topics = sorted(
        topics.items(),
        key=lambda x: x[1],
        reverse=True
    )

    return [t[0] for t in sorted_topics[:3]]


def format_mistakes(mistakes):
    return [
        f"{m['question']} → You chose {m['user_answer']} (Correct: {m['correct']})"
        for m in mistakes[-5:]
    ]