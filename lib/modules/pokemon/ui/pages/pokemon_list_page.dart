import 'package:flutter/material.dart';
import 'package:pokedex_app/modules/pokemon/config/environment.dart';
import 'package:pokedex_app/modules/pokemon/domain/services/pokemon_service.dart';
import 'package:pokedex_app/modules/pokemon/domain/utils/format_output.dart';
import 'package:pokedex_app/modules/pokemon/ui/pages/details_page.dart';
import '../../domain/model/pokemon.dart';
import '../widgets/pokemon_image.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  PokemonListPageState createState() => PokemonListPageState();
}

class PokemonListPageState extends State<PokemonListPage> {
  String nextPageUrl = Environment.apiUrl;
  List<PokemonDataAcess> pokemonList = [];
  final pokemonService = PokemonService();

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  Future<void> getAllData() async {
    while (nextPageUrl.isNotEmpty) {
      final data = await pokemonService.getAllData(nextPageUrl);
      setState(() {
        nextPageUrl = data?['next'] ?? '';
        final results = data?['results'] as List<dynamic>;
        pokemonList
            .addAll(results.map((result) => PokemonDataAcess.fromJson(result)).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];
              return InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        pokemonName: pokemon.name!,
                      ),
                    )),
                child: Card(
                  child: ListTile(
                    title: Text(
                      FormatOutput().capitalizeFirstLetter(pokemon.name!),
                      style: const TextStyle(
                        fontFamily: 'Pokemon',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: SizedBox(
                      child: Column(
                        children: [
                          PokemonImage(
                            pokemonName: pokemon.name!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
