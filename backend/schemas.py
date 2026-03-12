def question_serializer(question):
    return {
        "id": str(question["_id"]),
        "question": question["question"],
        "optionA": question["optionA"],
        "optionB": question["optionB"],
        "optionC": question["optionC"],
        "optionD": question["optionD"],
        "correctAnswer": question["correctAnswer"],
        "explanation": question["explanation"],
        "category": question["category"],
        "image": question.get("image"),
        "difficulty": question.get("difficulty"),
        "language": question.get("language")
    }