import 'package:flutter/material.dart';
import '../../domain/model/pokemon.dart';

class WrapPokemonTypesWidget extends StatelessWidget {
  const WrapPokemonTypesWidget({
    super.key,
    required this.pokemon,
  });

  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: pokemon!.types
          .map(
            (type) => Chip(
              label: Text(
                type,
                style: TextStyle(
                    fontStyle:
                        Theme.of(context).textTheme.displayMedium!.fontStyle),
              ),
              backgroundColor: getColorByType(type),
            ),
          )
          .toList(),
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
