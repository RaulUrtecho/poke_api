import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_api/poke_api.dart';

@GenerateNiceMocks([MockSpec<Client>()])
import 'poke_api_test.mocks.dart';

void main() {
  group('PokeApiService', () {
    late PokeApiService pokeApiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      pokeApiService = PokeApiService(client: mockClient);
    });

    test('getPokemonByName returns Pokemon when the http call completes successfully', () async {
      // Mock success Response
      final jsonResponse = json.encode({'name': 'pikachu', 'id': 25});

      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/pikachu')))
          .thenAnswer((_) async => Response(jsonResponse, 200));

      final result = await pokeApiService.getPokemonByName('pikachu');
      expect(result.name, 'pikachu');
      expect(result.id, 25);
    });

    test('getPokemonByName throws an exception when the http call fails', () async {
      // Mock Error Response
      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/pikachu')))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(() async => await pokeApiService.getPokemonByName('pikachu'),
          throwsA(isA<PokeApiException>()));
    });

    test('getPokemons returns a PokemonList when the http call completes successfully', () async {
      // Mock success Response
      final jsonResponse = json.encode({
        'count': 1,
        'next': '',
        'previous': '',
        'results': [
          {'name': 'pikachu', 'url': 'https://pokeapi.co/api/v2/pokemon/25/'}
        ]
      });
      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&offset=0')))
          .thenAnswer((_) async => Response(jsonResponse, 200));

      final result = await pokeApiService.getPokemons(0);
      expect(result.results.length, 1);
      expect(result.results[0].name, 'pikachu');
    });

    test('getPokemons throws an exception when the http call fails', () async {
      // Mock Error Response
      when(mockClient.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&offset=0')))
          .thenAnswer((_) async => Response('Not Found', 404));

      expect(() async => await pokeApiService.getPokemons(0),
          throwsA(isA<PokeApiException>()));
    });
  });
}
