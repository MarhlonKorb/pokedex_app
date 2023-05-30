
import '../model/pokemon.dart';
/// Interface da entidade Pokémon
abstract class IPokemonRepository {
  
  /// Retorna lista de [pokemon]
  Future<Map<String, dynamic>> getAllData(String url);

  /// Retorna a URL da imagem do [pokemon] de acordo com seu nome
  Future<String> getPokemonImageUrl(String pokemonName);

  /// Retorna os dados de um [pokemon]
  Future<Pokemon> fetchPokemon(String pokemonName);
}