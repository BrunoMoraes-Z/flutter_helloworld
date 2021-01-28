import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _output = TextEditingController();

  void _SearchRepo() async {
    if (_controller.text.trim().length > 0) {
      var url = 'https://api.github.com/repos/${_controller.text.trim()}';
      _output.text = url;
      try {
        var response = await http.get(url);
        var jsonResponse = convert.jsonDecode(response.body);
        _output.text = jsonResponse.toString();
      } catch (ex) {
        _output.text = ex.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      //unform/unform
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'repositório/projeto',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                              fontSize: 20)),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: FlatButton(
                        onPressed: () => _SearchRepo(),
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.search,
                          size: 45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _output
            )
          ],
        ),
      ),
    );
  }
}
