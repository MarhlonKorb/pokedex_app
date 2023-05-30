import 'package:flutter/material.dart';

import '../../domain/model/pokemon.dart';
/// Monta widget responsável por apresentar a lista de habilidades
class WrapPokemonAbilitiesListWidget extends StatelessWidget {
  const WrapPokemonAbilitiesListWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: pokemon!.abilities
          .map(
            (ability) => Chip(
              label: Text(
                ability,
                style: TextStyle(
                  fontSize: 11,
                    fontStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .fontStyle),
              ),
              backgroundColor:
                  Colors.blueGrey[200],
            ),
          )
          .toList(),
    );
  }
}