import 'package:dio/dio.dart';
import '../../../shared/errors/custom_error.model.dart';
import '../../../shared/models/deck.model.dart';
import '../../../shared/utils/constants.dart';

class DeckService {
  final Dio _dio;
  DeckService(this._dio);

  Future<Deck> createDeck(String name) async {
    try {
      final response = await _dio.post(
        '/decks',
        data: {
          'name': name,
        },
        options: Constants.dioOptions,
      );

      return Deck.fromMap(response.data);
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<List<Deck>> getDecks() async {
    try {
      final response = await _dio.get(
        '/decks',
        options: Constants.dioOptions,
      );

      return (response.data as List).map((e) => Deck.fromMap(e)).toList();
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<void> removeDeck(int deckId) async {
    try {
      await _dio.delete('/decks/$deckId', options: Constants.dioOptions);
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }
}
