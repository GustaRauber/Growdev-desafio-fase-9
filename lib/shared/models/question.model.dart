class Question {
  final int id;

  final String ask;

  final String answer;

  Question({
    required this.id,
    required this.ask,
    required this.answer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      ask: map['ask'] as String,
      answer: map['answer'] as String,
    );
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id && other.ask == ask && other.answer == answer;
  }

  @override
  int get hashCode => id.hashCode ^ ask.hashCode ^ answer.hashCode;
}
