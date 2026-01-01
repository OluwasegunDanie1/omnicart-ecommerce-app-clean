import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/screens/product_details.dart';
import 'package:omnicart/widget/app_bar.dart';
import 'package:omnicart/widget/products.dart';
import 'package:random_string/random_string.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final DbMethods dbMethods = DbMethods();
  Stream<QuerySnapshot>? productStream;

  String addId = randomAlphaNumeric(10);

  @override
  void initState() {
    productStream = dbMethods.getProducts(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: widget.category,
              icon: Icons.arrow_back_ios,
              iconic: Icons.shopping_cart_outlined,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: productStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.95,
                        ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final ds = snapshot.data!.docs[index];
                      final data = ds.data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetails(
                                name: data["name"],
                                price: (data["price"] as num).toDouble(),
                                category: data["category"],
                                imageBase64: data["imageBase64"],
                                desc: data["desc"],
                                id: addId,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          name: data["name"],
                          price: (data["price"] as num).toDouble(),
                          imageBase64: data["imageBase64"],
                          id: addId,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
