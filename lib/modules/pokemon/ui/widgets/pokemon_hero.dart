import 'package:flutter/material.dart';
import 'package:pokedex_app/modules/pokemon/ui/widgets/generic_futurebuilder.dart';
import '../../domain/services/pokemon_service.dart';

/// Hero que realiza animação da imagem na transição entre telas
class PokemonHero extends StatefulWidget {
  final String pokemonName;
  final double? width;

  const PokemonHero({super.key, required this.pokemonName, this.width});

  @override
  State<PokemonHero> createState() => _PokemonHeroState();
}

class _PokemonHeroState extends State<PokemonHero> {
  late Future<String> _imageUrlFuture;
  final pokemonService = PokemonService();

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = pokemonService.getPokemonImageUrl(widget.pokemonName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        child: GenericFutureBuilder<String>(
          future: _imageUrlFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final imageUrl = snapshot.data;
            return Hero(
              tag: widget.pokemonName,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.contain,
                    height: 180,
                    width: 180,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
