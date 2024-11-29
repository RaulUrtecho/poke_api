import 'package:poke_api/src/models/pokemon_list_item.dart';

class PokemonList {
  final int count;
  final String next;
  final String? previous;
  final List<PokemonListItem> results;

  const PokemonList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List.from(json['results']).map((e) => PokemonListItem.fromJson(e)).toList(),
    );
  }
}
