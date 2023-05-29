import 'package:flutter/material.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PokemonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Pokemon',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[400]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
