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
    'assets/images/promo1.png',
    'assets/images/promo2.png',
    'assets/images/promo3.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    Timer.periodic(const Duration(milliseconds: 3000), (Timer timer) {
      if (_currCarouselIdx < _carouselImages.length - 1) {
        _currCarouselIdx++;
      } else {
        _currCarouselIdx = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currCarouselIdx,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  //what are the use of dispose?
  //used pas kita pake carousel, timernya dimatiin when we leave page.
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
                accountEmail: Text("${widget.username}@fragstore.ac.id"),
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
              const Divider(),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                onTap: () => handleLogout(),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, //buat align, but why start
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currCarouselIdx = index;
                    });
                  },
                  itemCount: _carouselImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey,
                      width: 540,
                      height: 540,
                      child: Center(
                        child: Center(
                          child: Image.asset(_carouselImages[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),

              //buat Indicator Carouselny
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_carouselImages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: _currCarouselIdx == index
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 25),

              const Divider(height: 0.5, color: Colors.grey, thickness: 0.5),

              Center(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "About Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: const [
                    Icon(Icons.storefront, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      "Fragstore is the xxxxdhhhsajhkhdakasjhhhhdsaajhhkjS"
                      "Established in xx by AF :>",
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                child: Column(
                  children: [
                    Icon(Icons.info_rounded, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      "AF is Currently working on this Qualification Project hehe, i got this. dhhasjahdhhssakdhas",
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
