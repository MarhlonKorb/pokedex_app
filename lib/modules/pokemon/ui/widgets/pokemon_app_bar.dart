import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PokemonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: GoogleFonts.pressStart2p(
            textStyle: const TextStyle(fontSize: 18.0),
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
