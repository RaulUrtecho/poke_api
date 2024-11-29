class PokemonListItem {
  final String name;
  final String url;

  const PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(name: json['name'], url: json['url']);
  }
}
