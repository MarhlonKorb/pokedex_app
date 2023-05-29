import 'package:flutter/material.dart';
import 'package:pokedex_app/modules/pokemon/domain/services/pokemon_service.dart';
import 'package:pokedex_app/modules/pokemon/domain/utils/format_output.dart';
import 'package:pokedex_app/modules/pokemon/ui/widgets/pokemon_app_bar.dart';
import 'package:pokedex_app/modules/pokemon/ui/widgets/pokemon_hero.dart';

class DetailsPage extends StatefulWidget {
  final String pokemonName;

  const DetailsPage({super.key, required this.pokemonName});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final pokemonService = PokemonService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokemonAppBar(title: 'Informações'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: pokemonService.getPokemon(widget.pokemonName),
                builder: (context, snapshot) {
                  final pokemon = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text('Erro ao carregar dados do Pokémon');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PokemonHero(
                        pokemonName: widget.pokemonName,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome: ${FormatOutput().capitalizeFirstLetter(pokemon!.name)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Número: ${pokemon.number.toString()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Habilidades:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: pokemon.abilities
                                    .map(
                                      (ability) => Chip(
                                        label: Text(
                                          ability,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        backgroundColor: Colors.blueGrey[200],
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Tipos:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: pokemon.types
                                    .map(
                                      (type) => Chip(
                                        label: Text(
                                          type,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        backgroundColor: getColorByType(type),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Peso: ${pokemon.weight.toString()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Altura: ${pokemon.height.toString()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? getColorByType(String type) {
    switch (type) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'ice':
        return Colors.lightBlueAccent;
      case 'fighting':
        return Colors.red;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.grey[400];
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.indigo;
      case 'dark':
        return Colors.black87;
      case 'dragon':
        return Colors.indigoAccent;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }
}
