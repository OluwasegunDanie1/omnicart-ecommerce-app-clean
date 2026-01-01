import 'package:cloud_firestore/cloud_firestore.dart';

class DbMethods {
  Future<void> addUserDetails(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfo);
  }

  //addproduct
  Future addProduct(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(userInfoMap);
  }

  Stream<QuerySnapshot> getProducts([String? category]) {
    final collectionRef = FirebaseFirestore.instance.collection("Products");

    if (category != null && category.isNotEmpty) {
      // filter by category
      return collectionRef.where("category", isEqualTo: category).snapshots();
    } else {
      // fetch everything
      return collectionRef.snapshots();
    }
  }

  //

  Stream<QuerySnapshot> getAllOrders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await FirebaseFirestore.instance.collection("orders").doc(orderId).update({
      "status": status,
    });
  }

  //addtocart
  Future<void> addToCart({
    required String userId,
    required Map<String, dynamic> productData,
  }) async {
    final cartRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productData["id"]);

    final doc = await cartRef.get();

    if (doc.exists) {
      cartRef.update({"quantity": FieldValue.increment(1)});
    } else {
      cartRef.set(productData);
    }
  }

  //order details
  Future orderDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("orders")
        .add(userInfoMap);
  }

  //getOrders
  Stream<QuerySnapshot> getOrders(String email) {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("userEmail", isEqualTo: email)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
}
