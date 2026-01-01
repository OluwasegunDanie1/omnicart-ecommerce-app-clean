import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/screens/product_details.dart';
import 'package:omnicart/widget/app_bar.dart';
import 'package:omnicart/widget/daily_deals.dart';
import 'package:omnicart/widget/products.dart';
import 'package:random_string/random_string.dart';

class HomeScreen extends StatefulWidget {
  final String? category;
  const HomeScreen({super.key, this.category});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? categoryStream;
  final DbMethods dbMethods = DbMethods();
  String addId = randomAlphaNumeric(10);

  getOnTheLoad() {
    categoryStream = dbMethods.getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allProducts() {
    return Expanded(
      child: StreamBuilder(
        stream: categoryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
            ),

            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetails(
                        name: ds["name"],
                        price: (ds["price"] as num).toDouble(),
                        category: ds["category"],
                        imageBase64: ds["imageBase64"],
                        desc: ds["desc"],
                        id: addId,
                      ),
                    ),
                  );
                },
                child: ProductCard(
                  name: ds["name"],
                  price: (ds["price"] as num).toDouble(),
                  imageBase64: ds["imageBase64"],
                  id: addId,
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top bar
            CustomAppBar(
              icon: Icons.shopping_bag_outlined,
              iconi: Icons.search,
              iconic: Icons.shopping_cart_outlined,
              title: "",
            ),

            // Daily Deals
            DailyDeals(),
            SizedBox(height: 20),
            //TopPicks(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Top Picks for You", style: AppTextStyle.main),
            ),
            SizedBox(height: 20),
            allProducts(),
          ],
        ),
      ),
    );
  }
}
