
import 'package:flutter/material.dart';
import 'package:pokedex_app/modules/pokemon/domain/services/pokemon_service.dart';
import 'package:pokedex_app/modules/pokemon/domain/utils/format_output.dart';
import 'package:pokedex_app/modules/pokemon/ui/widgets/pokemon_app_bar.dart';
import 'package:pokedex_app/modules/pokemon/ui/widgets/pokemon_hero.dart';

import '../../domain/model/pokemon.dart';
import '../widgets/generic_futurebuilder.dart';
import '../widgets/wrap_pokemon_abilities_list_widget.dart';
import '../widgets/wrap_pokemon_types_list_widget.dart';
/// Página de detalhes do Pokémon
class DetailsPage extends StatefulWidget {
  final String pokemonName;

  const DetailsPage({Key? key, required this.pokemonName}) : super(key: key);

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
  void dispose() {
    super.dispose();
    imageCache.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokemonAppBar(title: 'Informações'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GenericFutureBuilder<Pokemon>(
                    future: pokemonService.getPokemon(widget.pokemonName),
                    builder: (context, snapshot) {
                      final pokemon = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: PokemonHero(
                              pokemonName: widget.pokemonName,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nome: ${FormatOutput().capitalizeFirstLetter(pokemon!.name)}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .fontStyle),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Número: ${pokemon.number.toString()}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .fontStyle),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Habilidades:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .fontStyle),
                                  ),
                                  WrapPokemonAbilitiesListWidget(
                                      pokemon: pokemon),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Tipos:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .fontStyle),
                                  ),
                                  WrapPokemonTypesWidget(pokemon: pokemon),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Peso: ${pokemon.weight.toString()}Kg',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .fontStyle),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Altura: ${pokemon.height.toString()}m',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontStyle,
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
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                ),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
