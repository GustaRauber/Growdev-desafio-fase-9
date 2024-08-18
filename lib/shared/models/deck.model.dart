// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'question.model.dart';

class Deck {
  final int id;

  final String name;

  final List<Question> questions;

  Deck({
    required this.id,
    required this.name,
    this.questions = const [],
  });

  Deck copyWith({
    int? id,
    String? name,
    List<Question>? questions,
  }) {
    return Deck(
      id: id ?? this.id,
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      id: map['id'] as int,
      name: map['name'] as String,
      questions: List<Question>.from(
        (map['questions'] as List).map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool operator ==(covariant Deck other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ questions.hashCode;
}
