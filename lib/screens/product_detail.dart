import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_assessment/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int itemCount = 0;
  void increaseItemCount() {
    setState(() {
      itemCount++;
    });
  }

  void decreaseItemCount() {
    if (itemCount > 0) {
      setState(() {
        itemCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.product.title!),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.image!,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 350,
                placeholder: (context, url) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.orange[900],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Getting item image",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(185, 255, 235, 59),
                      ),
                      Text(widget.product.rating != null
                          ? widget.product.rating!.rate.toString()
                          : '')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.description!,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.green),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            increaseItemCount();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          itemCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            decreaseItemCount();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < itemCount; i++) {
                        Provider.of<Cart>(context, listen: false).addItem(
                          product: widget.product,
                        );
                      }
                      setState(() {
                        itemCount = 0;
                      });
                      Navigator.pushNamed(context, '/cart');
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(190, 50)),
                    child: Row(
                      children: [
                        const Text(
                          'Add To Card',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        badges.Badge(
                          badgeContent: Text(
                            Provider.of<Cart>(context, listen: true)
                                .totalItemCount
                                .toString(),
                          ),
                          child: const Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
