class AddQuestionDto {
  final int deckId;
  final String ask;
  final String answer;

  AddQuestionDto({
    required this.deckId,
    required this.ask,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ask': ask,
      'answer': answer,
    };
  }
}
