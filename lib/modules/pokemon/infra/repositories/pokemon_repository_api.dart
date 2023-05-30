import 'dart:convert';
import 'package:pokedex_app/modules/pokemon/config/environment.dart';
import 'package:pokedex_app/modules/pokemon/domain/repositories/i_pokemon_repository.dart';
import 'package:http/http.dart' as http;

import '../../domain/model/pokemon.dart';

class PokemonRepositoryApi extends IPokemonRepository {
  final apiUrl = Environment.apiUrl;

  @override
  Future<Map<String, dynamic>> getAllData(String url) async {
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  @override
  Future<String> getPokemonImageUrl(String pokemonName) async {
    final url = '$apiUrl/$pokemonName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final imageUrl = jsonData['sprites']['front_default'];
      return imageUrl;
    } else {
      throw Exception('Falha ao obter a imagem do Pokémon.');
    }
  }

  @override
  Future<Pokemon> fetchPokemon(String pokemonName) async {
  final url = '$apiUrl/$pokemonName';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final pokemon = Pokemon.fromJson(jsonData);
    return pokemon;
  } else {
    throw Exception('Falha ao carregar os dados do Pokómon.');
  }
}
}
