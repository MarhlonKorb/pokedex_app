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