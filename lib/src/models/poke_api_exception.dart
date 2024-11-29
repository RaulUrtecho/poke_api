class PokeApiException implements Exception {
  final String message;
  PokeApiException(this.message);

  @override
  String toString() => 'PokeApiException: $message';
}
