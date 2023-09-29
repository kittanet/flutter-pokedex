import 'dart:convert';
import 'package:demo/model/PokedexModel.dart';
import 'package:demo/model/PokemonDetailModel.dart';
import 'package:http/http.dart' as http;

class PokedexService {
  Future<List<PokemonDetail>> getPokedex(int limit, int offset) async {
    List<PokemonDetail> result = [];
    var response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load Pokedex');
    }
    var pokexdex = PokedexModel.fromJson(jsonDecode(response.body));

    for (var pokemon in pokexdex.results ?? []) {
      print(pokemon.name);
      result.add(await getPokemon(pokemon.url));
    }

    return result;
  }

  Future<PokemonDetail> getPokemon(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load Pokemon');
    }
    return PokemonDetail.fromJson(jsonDecode(response.body));
  }
}
