import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/pages/LoginPage..dart';

class Homepage extends StatefulWidget {
  final String username;

  const Homepage({Key? key, required this.username}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isDarkMode = false;
  int _currCarouselIdx = 0;
  late PageController _pageController;

  final List<String> _carouselImages = [
    //templatein dl ubahh nnti
    'assets/image/promo1.png',
    'assets/image/promo2.png',
    'assets/image/promo3.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  //what are the use of dispose?
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("FragStore - Home"),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  _isDarkMode = value == 'Dark';
                });
              },
              itemBuilder: (BuildContext context) {
                return {'Light', 'Dark'}.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              },
            ),
          ],
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(widget.username),
                accountEmail: Text("Dummy@FragStore.ac.id"),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text("Products"),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                onTap: () => handleLogout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
