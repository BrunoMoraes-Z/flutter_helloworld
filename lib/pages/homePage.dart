import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert' as convert;
import 'package:hello_world/models/Repository.dart';
import 'package:hello_world/models/RepositoryItem.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _output = TextEditingController();
  var repos = new List<Repository>();

  void _SearchRepo() async {
    if (_controller.text.trim().length > 0) {
      var url = 'https://api.github.com/repos/${_controller.text.trim()}';
      try {
        var response = await http.get(url);
        var jsonResponse = convert.jsonDecode(response.body);
        setState(() {
          if (response.statusCode == 200) {
            repos.add(Repository(
              name: jsonResponse['name'],
              fullName: jsonResponse['full_name'],
              description: jsonResponse['description'],
              starts: jsonResponse['stargazers_count'],
              issues: jsonResponse['open_issues_count'],
            ));
          } else {
            //todo
          }
        });
        // _output.text = repos[1].toJson().toString();
      } catch (ex) {
        setState(() {
          _output.text = ex.toString();
        });
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
                          size: 35,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    repos.length > 0
                        ? repos.length > 1
                            ? '${repos.length} Repositórios'
                            : '1 Repositório'
                        : ' ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              itemCount: repos.length,
              shrinkWrap: true,
              itemBuilder: (ctx, ind) => Container(
                height: 65,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('-x-'),
                        SizedBox(
                          height: 2,
                        ),
                        Text(repos[ind].name == null ? 'null' : repos[ind].name),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Issues',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${repos[ind].issues} '),
                            Icon(
                              Icons.file_copy,
                              size: 15,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${repos[ind].starts} '),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
