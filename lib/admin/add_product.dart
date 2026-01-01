import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/widget/app_bar.dart';
import 'package:omnicart/widget/custom_buttons.dart';
import 'package:omnicart/widget/mytext_field.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String selectedCategory = "";
  String? base64Image;
  final TextEditingController name = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController price = TextEditingController();

  //image picker
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  //convert image to base64
  Future<void> convertImageToBase64() async {
    if (selectedImage != null) {
      List<int> imageBytes = await selectedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }
  }

  final DbMethods dbMethods = DbMethods();
  //get image
  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  //upload item to firestore
  bool isLoading = false;

  Future<void> uploadItem() async {
    if (selectedImage != null &&
        name.text.isNotEmpty &&
        price.text.isNotEmpty &&
        selectedCategory.isNotEmpty) {
      setState(() => isLoading = true);

      String addId = randomAlphaNumeric(10);
      await convertImageToBase64();

      // Create product map
      Map<String, dynamic> userInfoMap = {
        "id": addId,
        "name": name.text.trim(),
        "price": double.tryParse(price.text.trim()) ?? 0.0,
        "category": selectedCategory,
        "desc": desc.text.trim(),
        "imageBase64": base64Image,
        "createdAt": Timestamp.now(),
      };

      await dbMethods.addProduct(userInfoMap);

      setState(() => isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product Uploaded Successfully")));

      // Clear fields
      name.clear();
      price.clear();
      desc.clear();
      category.clear();
      selectedImage = null;
      setState(() {});
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Add Product",
                icon: Icons.arrow_back_ios,
                iconi: Icons.share_outlined,
                iconic: Icons.shopping_cart_outlined,
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New Product Details", style: AppTextStyle.main),
                    SizedBox(height: 20),
                    myTextField(title: "Product Name", controller: name),
                    SizedBox(height: 15),
                    myTextField(
                      title: "Product Description",
                      maxlines: 4,
                      controller: desc,
                    ),
                    SizedBox(height: 15),
                    Text("Category", style: AppTextStyle.avgmain),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Category",
                      ),
                      items:
                          [
                                "Electronics",
                                "Clothings",
                                "Food & Groceries",
                                "Home Goods",
                              ]
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    myTextField(title: "Price", controller: price),
                    SizedBox(height: 15),
                    Text("Product Image", style: AppTextStyle.avgmain),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedImage == null
                              ? GestureDetector(
                                  onTap: getImage,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 40,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Drag & drop image or click to upload",
                                        style: AppTextStyle.submain,
                                      ),
                                    ],
                                  ),
                                )
                              : Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      selectedImage!,
                                      height: 148,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                            title: "Save Product",
                            onPressed: uploadItem,
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
