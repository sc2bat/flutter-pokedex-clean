import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../domain/model/pokemon_test.dart';

void main() {
  test('pokemon api testing', () async {
    const url =
        'https://gist.githubusercontent.com/sc2bat/28d2991fb9e361f0e50fd52ac7c40774/raw/a72d0f8ddfcbff5dc523f626c96f4ef1f1f2e0f4/pokemon_data.json';

    final response = await http.get(Uri.parse(url));

    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<Map<String, dynamic>> pokemonListJson =
        jsonData.cast<Map<String, dynamic>>();
    expect(pokemonListJson.length, 1010);
  });

  test('pokemon json to dart testing', () async {
    const url =
        'https://gist.githubusercontent.com/sc2bat/28d2991fb9e361f0e50fd52ac7c40774/raw/a72d0f8ddfcbff5dc523f626c96f4ef1f1f2e0f4/pokemon_data.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      expect(jsonData.length, 1010);
      final List<PokemonTest> pokemonList =
          jsonData.map((json) => PokemonTest.fromJson(json)).toList();
      expect(pokemonList.length, 1010);
    }
  });
}
