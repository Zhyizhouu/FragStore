import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; //importan http -_-
import 'package:mobile_app/models/Product.dart';
import 'package:mobile_app/pages/DetailPage.dart';
import 'package:mobile_app/pages/HomePage.dart';
import 'package:mobile_app/pages/LoginPage..dart';

class ItemPage extends StatefulWidget {
  final String username;
  const ItemPage({super.key, required this.username});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  bool _isLoading = true;

  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const String apiUrl = "http://10.0.2.2:3000/api/products";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        final List<dynamic> productList = data['data'];
        //mksdny data disini apa? knp data dlm array data?
        //=> data yang kiri (var kt), => [data] yg kanan => dari jsonnya yg backend
        setState(() {
          _products = productList
              .map((json) => Product.fromJson(json))
              .toList();
          //kta converting the productList and saving it too the list Product
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error: ${e}");
    }
    ;
  }

  void handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FragStore - ItemPage")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("${widget.username}"),
              accountEmail: Text("${widget.username}@fragstore.ac.id"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Homepage(username: widget.username);
                    },
                  ),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Products"),
              onTap: () => {},
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => handleLogout(),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailPage(
                            product: product,
                            username: widget.username,
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              Text("RP ${product.price}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
