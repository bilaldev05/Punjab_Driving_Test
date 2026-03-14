def question_serializer(question):
    return {
        "id": str(question["_id"]),
        "question": question.get("question", ""),
        "questionUr": question.get("questionUr", ""),
        "optionA": question.get("optionA", ""),
        "optionAUr": question.get("optionAUr", ""),
        "optionB": question.get("optionB", ""),
        "optionBUr": question.get("optionBUr", ""),
        "optionC": question.get("optionC", ""),
        "optionCUr": question.get("optionCUr", ""),
        "optionD": question.get("optionD", ""),
        "optionDUr": question.get("optionDUr", ""),
        "correctAnswer": question.get("correctAnswer", ""),
        "explanation": question.get("explanation", "No explanation available."),
        "explanationUr": question.get("explanationUr", "کوئی وضاحت دستیاب نہیں۔"),
    }