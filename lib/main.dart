import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: HomePage());
  }
}

enum _State { LOADING, DONE, ERROR, SUCCESS }

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State {
  _State _state = _State.LOADING;
  Map<String, dynamic> _pokedex = {};

  @override
  void initState() {
    super.initState();
    fetchPokeDex();
  }

  Future<void> fetchPokeDex() async {
    Uri _uri = Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

    await http.get(_uri).then((response) {
      setState(() {
        _pokedex = jsonDecode(response.body);
        _state = _State.DONE;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.yellow[700],
      ),
      body: _state == _State.LOADING
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: _pokedex["pokemon"]
                  .map<Widget>((poketmon) => Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(poketmon["num"]),
                            Text(poketmon["name"]),
                            Image.network(poketmon["img"])
                          ],
                        ),
                      ))
                  .toList()),
    );
  }
}
