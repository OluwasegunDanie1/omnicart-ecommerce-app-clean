import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/widget/app_bar.dart';
import 'package:omnicart/widget/categoryT_tile.dart';

class Categories extends StatefulWidget {
  //final String category;
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // Stream? categoryStream;
  // final DbMethods dbMethods = DbMethods();
  // Future<void> getOnTheLoad() async {
  //   categoryStream = await dbMethods.getProducts(widget.category);
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   getOnTheLoad();
  //   super.initState();
  // }

  // Widget allProducts(){
  //   return StreamBuilder(stream: categoryStream, builder: (BuildContext context, AsyncSnapshot snapshot){
  //      return snapshot.hasData? GridView.builder(padding: EdgeInsets.zero, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: snapshot.data.docs.length, itemBuilder: (context, index){
  //       DocumentSnapshot ds = snapshot.hasData.docs[index];
  //       return Container();

  //      });
  //   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "",
              icon: Icons.arrow_back_ios,

              iconic: Icons.shopping_cart_outlined,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Explore Categories", style: AppTextStyle.main),
            ),
            SizedBox(height: 10),
            CategorytTile(
              title: "Electronics",
              subtitle: "Find the latest gadgets",
              icon: Icons.monitor,
            ),
            CategorytTile(
              title: "Clothings",
              subtitle: "Browse trendy appare",
              icon: Icons.checkroom,
            ),
            CategorytTile(
              title: "Food & Groceries",
              subtitle: "Fresh produce",
              icon: Icons.restaurant,
            ),
            CategorytTile(
              title: "Home Goods",
              subtitle: "Decorate your living space.",
              icon: Icons.home_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
