import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    return const MaterialApp(
        initialRoute: AppRoutes.pokemonListPage,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PokemonAppBar(title: 'Pokedéx App'),
          body: PokemonListPage(),
        ));
  }
}


