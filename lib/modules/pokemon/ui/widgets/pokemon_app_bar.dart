import 'package:flutter/material.dart';

/// AppBar do aplicativo
class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PokemonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 17.0),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
