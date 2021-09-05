import 'package:flutter/material.dart';

import 'package:pokedex/view/util.dart';
import 'package:provider/provider.dart';

import 'data/provider.dart';
import 'view/detail.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyProvider>(create: (context) => MyProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State {
  @override
  void initState() {
    super.initState();
    fetchPokeDex();
  }

  Future<void> fetchPokeDex() async {
    await Provider.of<MyProvider>(context, listen: false).fetchPokeDex();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Provider.of<MyProvider>(context, listen: false).getState() ==
              MyState.LOADING
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: Provider.of<MyProvider>(context, listen: false)
                  .getPokeDex()["pokemon"]
                  .map<Widget>((poketmon) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(poketmon)));
                        },
                        child: Hero(
                            tag: poketmon,
                            child: Card(
                              color: MyColor[poketmon["type"][0].toString()],
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(poketmon["num"], style: s_textStyle),
                                  Text("Type" + poketmon["type"][0],
                                      style: s_textStyle),
                                  Text(poketmon["name"], style: s_textStyle),
                                  Image.network(poketmon["img"])
                                ],
                              ),
                            )),
                      ))
                  .toList()),
    );
  }
}
