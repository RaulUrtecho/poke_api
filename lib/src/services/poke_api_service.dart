import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poke_api/poke_api.dart';

class PokeApiService {
  final _baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final http.Client _httpClient;
  final int defaultLimit;

  PokeApiService({http.Client? client, this.defaultLimit = 10}) : _httpClient = client ?? http.Client();

  /// Fetches a Pokémon by its name.
  ///
  /// Returns a [Pokemon] object with detailed data.
  Future<Pokemon> getPokemonByName(String name) async {
    final res = await _httpClient.get(Uri.parse('$_baseUrl/${name.toLowerCase()}'));
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      return Pokemon.fromJson((body is String) ? {'name': body, 'id': 0} : body);
    }
    throw PokeApiException('Failed to load Pokémon: $name');
  }

  /// Retrieves a list of Pokémon starting from a specific index.
  ///
  /// The optional [limit] parameter controls the number of results.
  /// The index to [start] fetching Pokémon from (e.g., 0 for the first Pokémon).
  Future<PokemonList> getPokemons(int start, {int? limit}) async {
    final res = await _httpClient.get(Uri.parse('$_baseUrl?limit=${limit ?? defaultLimit}&offset=$start'));
    if (res.statusCode == 200) {
      return PokemonList.fromJson(json.decode(res.body));
    }
    throw PokeApiException('Failed to load Pokémon list');
  }
}
