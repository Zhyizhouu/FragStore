import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final String? username;

  const Homepage({Key? key, required this.username}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Container(
        child: Column(children: [Text("Welcome, ${widget.username}")]),
      ),
    );
  }
}
