import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../models/product/product.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    print('testing here');
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    print('testing here');
    final List<dynamic> productData = json.decode(response.body);
    setState(() {
      _products = productData.map((json) => Product.fromMap(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: badges.Badge(
                badgeContent: Text(
                  Provider.of<Cart>(context, listen: true)
                      .totalItemCount
                      .toString(),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () async {
              await _fetchProducts();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _products.length,
              itemBuilder: (ctx, i) => ProductItem(product: _products[i]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
