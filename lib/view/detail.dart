import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/provider.dart';
import 'util.dart';

class DetailPage extends StatefulWidget {
  Map<String, dynamic> _poketmon = {};

  DetailPage(Map<String, dynamic> poketmon) {
    _poketmon = poketmon;
  }

  @override
  _DetailPage createState() => _DetailPage(_poketmon);
}

class _DetailPage extends State<DetailPage> {
  Map<String, dynamic> _poketmon = {};

  _DetailPage(Map<String, dynamic> poketmon) {
    _poketmon = poketmon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_poketmon["name"]),
          backgroundColor: Colors.yellow[700],
        ),
        body: Container(
            // alignment: Alignment.center,
            color: MyColor[_poketmon["type"][0].toString()],
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * (7 / 10),
              child: Hero(
                tag: _poketmon,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _poketmon["num"],
                        style: m_textStyle,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(20),
                          height: 60,
                          color: Colors.yellow[50],
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                _poketmon["name"],
                                style: m_textStyle,
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              SizedBox(
                                width: 100,
                                // height: 40,
                                child: GridView.count(
                                  crossAxisSpacing: 10,
                                  crossAxisCount: _poketmon["type"].length,
                                  // padding: EdgeInsets.all(5),
                                  children: _poketmon["type"].map<Widget>((e) {
                                    return Container(
                                        color: MyColor[e],
                                        child: Text(e, style: s_textStyle));
                                  }).toList(),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        _poketmon["img"],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.yellow[50],
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                _CustomText("Height: ${_poketmon["height"]}"),
                                _CustomText("Weight: ${_poketmon["weight"]}"),
                                _CustomText(_poketmon["egg"]),
                                _CustomText("Weakness"),
                                SizedBox(
                                  height: 100,
                                  child: GridView.count(
                                    crossAxisSpacing: 10,
                                    crossAxisCount:
                                        _poketmon["weaknesses"].length,
                                    padding: EdgeInsets.all(5),
                                    children: _poketmon["weaknesses"]
                                        .map<Widget>((e) {
                                      return Container(
                                          height: 40,
                                          color: MyColor[e],
                                          child: Text(e, style: m_textStyle));
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                _poketmon["next_evolution"] != null
                                    ? SizedBox(
                                        height: 150,
                                        child: GridView.count(
                                          crossAxisSpacing: 10,
                                          crossAxisCount:
                                              _poketmon["next_evolution"]
                                                  .length,
                                          padding: EdgeInsets.all(5),
                                          children: _poketmon["next_evolution"]
                                              .map<Widget>((e) {
                                            return SizedBox(
                                                height: 60,
                                                // color: Color,
                                                child: Column(children: [
                                                  // Text(e["num"],
                                                  //     style: m_textStyle),
                                                  Text(e["name"],
                                                      style: m_textStyle),
                                                  Image.network(
                                                      Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getPokeDex()[
                                                          "pokemon"][int.parse(
                                                              e["num"]) -
                                                          1]["img"]),
                                                ]));
                                          }).toList(),
                                        ),
                                      )
                                    : Text(
                                        "완전체",
                                        style: m_textStyle,
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class _CustomText extends StatelessWidget {
  String _text = "";
  _CustomText(String text) {
    _text = text;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: Text(
        _text,
        style: m_textStyle,
      ),
    );
  }
}
