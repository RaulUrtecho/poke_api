import 'package:poke_api/poke_api.dart';

void main() async {
  final service = PokeApiService();
  final data = await service.getPokemonByName('charmander');
  print('${data.id} ${data.name}');
}