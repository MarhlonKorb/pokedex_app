import 'package:pokedex_app/modules/pokemon/domain/model/pokemon.dart';
import 'package:pokedex_app/modules/pokemon/infra/repositories/pokemon_repository_api.dart';

class PokemonService {
  final pokemonRepository = PokemonRepositoryApi();

  Future<Map<String, dynamic>?> getAllData(String url) {
    return pokemonRepository.getAllData(url);
  }

  Future<String> getPokemonImageUrl(String pokemonName) {
    return pokemonRepository.getPokemonImageUrl(pokemonName);
  }

  Future<Pokemon> getPokemon(String pokemonName) {
    return pokemonRepository.fetchPokemon(pokemonName);
  }
}
