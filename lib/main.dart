import 'package:flutter/material.dart';
import 'package:hello_world/models/Repository.dart';
import 'package:hello_world/pages/detailsPage.dart';
import 'package:hello_world/pages/homePage.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      // home: DetailsPage(
      //   Repository(
      //       name: 'Magma',
      //       fullName: 'unform/unform',
      //       description:
      //           'Minecraft Forge Hybrid server implementing the Spigot/Bukkit API (Cauldron for 1.12)',
      //       starts: 238,
      //       issues: 17,
      //       owner: 'https://api.github.com/users/magmafoundation'),
      // ),
      home: HomePage(),
    );
  }
}
