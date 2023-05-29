import 'package:flutter/material.dart';
import '../../domain/services/pokemon_service.dart';

class PokemonHero extends StatefulWidget {
  final String pokemonName;
  final double? width;

  const PokemonHero(
      {super.key, required this.pokemonName, this.width});

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
        child: FutureBuilder(
          future: _imageUrlFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                  'Erro ao carregar imagem na tela de informações.');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Hero(
              tag: widget.pokemonName,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.network(
                    snapshot.data ?? '',
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
