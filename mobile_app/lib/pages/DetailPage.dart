import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_app/models/Product.dart';
import 'package:mobile_app/models/Review.dart';

class DetailPage extends StatefulWidget {
  final String username;
  final Product product;
  const DetailPage({super.key, required this.product, required this.username});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController _pageController = PageController(); //geser2Halaman

  int _selectedIndex = 0;
  bool _isLoading = false;
  bool _isSending = false;
  final TextEditingController _commentController = TextEditingController();

  final List<Map<String, String>> _dummyReivew = [
    {
      "username": "ProGamer99",
      "content": "Mouse ini licin banget!",
      "rating": "5.0",
    },
    {
      "username": "CasualPlayer",
      "content": "Pengiriman agak lama.",
      "rating": "4.0",
    },
    {
      "username": "SultanVoucher",
      "content": "Worth it parah.",
      "rating": "5.0",
    },
  ];

  @override
  void dispose() {
    //bakalan kepake untuk mencegah memoryLeak
    _commentController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 2500),
      curve: Curves.easeIn,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _submitReview() async {
    if (_commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Komennya mana kak?!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    const String apiUrl = "http://10.0.2.2:3000/api/review";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "productID": widget.product.id,
          "username": widget.username,
          "comment": _commentController.text,
          "rating": "4.5",
        }),
      );
      if (response.statusCode == 201) {
        const SnackBar(
          content: Text("Review sent!"),
          backgroundColor: Colors.green,
        );
        _commentController.clear();
        fetchReviews();
      } else {
        throw Exception("Gagal : ${response.statusCode}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
    ;
  }

  List<Review> _reviews = [];

  Future<void> fetchReviews() async {
    String apiUrl = "http://10.0.2.2:3000/api/review/${widget.product.id}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(response.body);
        final List<dynamic> reviewsList = data['data'];
        setState(() {
          _reviews = reviewsList.map((json) => Review.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw new Exception("Failed to load products");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error $e");
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.product.name}")),
      body: PageView(
        controller: _pageController,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                ),
                const SizedBox(height: 20),
                Text("${widget.product.name}"),
                const SizedBox(height: 20),
                Text("Rp.${widget.product.price}"),
                const SizedBox(height: 20),
                Text("${widget.product.description}"),
                const SizedBox(height: 20),
                Text("${widget.product.rating}"),
                const Divider(thickness: 2),
                Text(
                  "Tulis reveiew kamu",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: "Barangnya bagaus",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _submitReview,
                    child: _isSending
                        ? const Text("Sending")
                        : const Text("Submit Review"),
                  ),
                ),
              ],
            ),
          ),

          //ini buat hal keduany
          ListView.builder(
            itemCount: _reviews.length,
            itemBuilder: (context, index) {
              final review = _reviews[index];
              return ListTile(
                leading: CircleAvatar(child: Text(review.username[0])),
                title: Text(review.username),
                subtitle: Text(review.comment),
                trailing: Text(review.rating),
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
          _pageController.animateToPage(
            _selectedIndex,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Detail"),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: "Reviews"),
        ],
      ),
    );
  }
}
