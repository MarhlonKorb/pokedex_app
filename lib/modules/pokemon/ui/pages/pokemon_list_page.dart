import 'package:flutter/material.dart';
import 'package:pokedex_app/modules/pokemon/config/environment.dart';
import 'package:pokedex_app/modules/pokemon/domain/services/pokemon_service.dart';
import 'package:pokedex_app/modules/pokemon/domain/utils/format_output.dart';
import 'package:pokedex_app/modules/pokemon/ui/pages/details_page.dart';
import '../../domain/model/pokemon_data_acess.dart';
import '../widgets/pokemon_image.dart';
/// Página de listagem de Pokémons
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  PokemonListPageState createState() => PokemonListPageState();
}

class PokemonListPageState extends State<PokemonListPage> {
  String nextPageUrl = Environment.apiUrl;
  List<PokemonDataAcess> pokemonList = [];
  List<PokemonDataAcess> filteredList = [];
  final pokemonService = PokemonService();
  final TextEditingController _searchController = TextEditingController();

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
        pokemonList.addAll(results
            .map((result) => PokemonDataAcess.fromJson(result))
            .toList());
        filteredList.addAll(pokemonList);
      });
    }
  }

/// Realiza a busca de acordo com digitação do usuário
  void filterPokemons(String searchText) {
    setState(() {
      filteredList = pokemonList
          .where((pokemon) =>
              pokemon.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(fontSize: 14),
              controller: _searchController,
              onChanged: (value) {
                filterPokemons(value);
              },
              decoration: InputDecoration(
                labelText: 'Pesquisar Pokémon',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),

              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final pokemon = filteredList[index];
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        pokemonName: pokemon.name!,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListTile(
                          title: Text(
                            FormatOutput().capitalizeFirstLetter(pokemon.name!),
                            style: Theme.of(context).textTheme.bodySmall,
                            softWrap: true,
                          ),
                          leading: SizedBox(
                            child: Column(
                              children: [
                                PokemonIconImage(
                                  pokemonName: pokemon.name!,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
