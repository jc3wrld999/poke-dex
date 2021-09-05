import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProvider with ChangeNotifier {
  MyState _state = MyState.LOADING;
  Map<String, dynamic> _pokedex = {};

  MyState getState() => _state;
  Map<String, dynamic> getPokeDex() => _pokedex;

  fetchPokeDex() async {
    Uri _uri = Uri.parse(
        "http://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

    http.Response _response = await http.get(_uri);

    _pokedex = jsonDecode(_response.body);

    _state = MyState.DONE;
  }
}

enum MyState { LOADING, DONE }

Map<String, Color> MyColor = {
  "Fire": Color(0XFFFDDFDF),
  "Grass": Color(0XFFDEFDE0),
  "Electric": Color(0XFFFCF7DE),
  "Water": Color(0XFFDEF3FD),
  "Ground": Color(0xfff4e7da),
  "Rock": Color(0xffd5d5d4),
  "Fairy": Color(0xfffceaff),
  "Poison": Color(0xff98d7a5),
  "Bug": Color(0xfff8d5a3),
  "Dragon": Color(0xff97b3e6),
  "Psychic": Color(0xffeaeda1),
  "Flying": Color(0xffF5F5F5),
  "Fighting": Color(0xffE6E0D4),
  "Normal": Color(0xffF5F5F5)
};
