import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_app/modules/pokemon/ui/pages/pokemon_list_page.dart';
import 'modules/pokemon/ui/pages/app_routes.dart';
import 'modules/pokemon/ui/widgets/pokemon_app_bar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: Colors.red[400]!,
          onPrimary: Colors.black,
          secondary: Colors.red[400]!,
          onSecondary: Colors.black,
          error: Colors.red[400]!,
          onError: Colors.black,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
        textTheme:
            GoogleFonts.pressStart2pTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: AppRoutes.pokemonListPage,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        appBar: PokemonAppBar(title: 'Pokédex App'),
        body: PokemonListPage(),
      ),
    );
  }
}
