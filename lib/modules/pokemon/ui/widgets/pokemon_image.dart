import 'package:flutter/material.dart';
import '../../domain/services/pokemon_service.dart';

class PokemonImage extends StatefulWidget {
  final String? pokemonName;
  final String? urlImage;

  const PokemonImage({super.key, this.pokemonName, this.urlImage});

  @override
  PokemonImageState createState() => PokemonImageState();
}

class PokemonImageState extends State<PokemonImage> {
  late Future<String> _imageUrlFuture;
  final pokemonService = PokemonService();

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = pokemonService.getPokemonImageUrl(widget.pokemonName!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _imageUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Erro ao carregar a imagem do Pokémon');
        }
          final imageUrl = snapshot.data!;
          return ClipRRect(
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.height * 0.062,
              fit: BoxFit.cover,
            ),
          );
        }
    );
  }
}
