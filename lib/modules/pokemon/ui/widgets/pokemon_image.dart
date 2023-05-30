import 'package:flutter/material.dart';
import 'package:pokedex_app/modules/pokemon/ui/widgets/generic_futurebuilder.dart';
import '../../domain/services/pokemon_service.dart';

/// Carrega ícone da imagem do pokémon
class PokemonIconImage extends StatefulWidget {
  final String? pokemonName;
  final String? urlImage;

  const PokemonIconImage({super.key, this.pokemonName, this.urlImage});

  @override
  PokemonIconImageState createState() => PokemonIconImageState();
}

class PokemonIconImageState extends State<PokemonIconImage> {
  late Future<String> _imageUrlFuture;
  final pokemonService = PokemonService();

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = pokemonService.getPokemonImageUrl(widget.pokemonName!);
  }

  @override
  Widget build(BuildContext context) {
    return GenericFutureBuilder<String>(
      future: _imageUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
