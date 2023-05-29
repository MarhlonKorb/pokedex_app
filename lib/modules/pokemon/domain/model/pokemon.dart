import 'dart:convert';

class PokemonDataAcess {
  late final String? name;
  late final String? url;
  late final String? hashcode;

  PokemonDataAcess({this.name, this.url, this.hashcode});

  factory PokemonDataAcess.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('name') && json.containsKey('url')) {
      return PokemonDataAcess(
        name: json['name'].toString(),
        url: json['url'].toString(),
        hashcode: json['hashcode'].toString(),
      );
    } else {
      throw Exception('Falha ao decodificar os dados do Pokémon.');
    }
  }

  String toJson() => json.encode(toMap());

  factory PokemonDataAcess.fromMap(Map<String, dynamic> json) => PokemonDataAcess(
        name: json["name"],
        url: json["url"],
        hashcode: json["hashcode"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
        "hashcode": hashcode,
      };
}

class Pokemon {
  final String name;
  final int number;
  final double height;
  final double weight;
  final List<String> types;
  final List<String> abilities;

  Pokemon({
    required this.name,
    required this.number,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final number = json['id'];
    final height = json['height'] / 10.0;
    final weight = json['weight'] / 10.0; 
    final types = (json['types'] as List<dynamic>)
        .map((type) => type['type']['name'].toString())
        .toList();
    final abilities = (json['abilities'] as List<dynamic>)
        .map((ability) => ability['ability']['name'].toString())
        .toList();

    return Pokemon(
      name: name,
      number: number,
      height: height,
      weight: weight,
      types: types,
      abilities: abilities,
    );
  }
}