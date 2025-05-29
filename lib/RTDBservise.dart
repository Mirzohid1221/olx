import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'Product_model.dart';

class RTDBservise {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<void> addProduct(ProductModel product) async {
    DatabaseReference newRef = _database.child("product").push();
    String id = newRef.key!;
    product.id = id;

    await newRef.set(product.toJson());
  }

  static Future<List<ProductModel>> getProduct() async {
    List<ProductModel> products = [];

    var query = _database.child('product');
    DatabaseEvent event = await query.once();
    var snapshot = event.snapshot;

    for (var product in snapshot.children) {
      var jsonmenu = jsonEncode(product.value);
      Map<String, dynamic> map = jsonDecode(jsonmenu);

      var itemProduct = ProductModel(
        id: map['id'],
        productName: map['productName'],
        productPrice: map['productPrice'],
        location: map['location'],
        imageUrl: map['imageUrl'],
      );

      products.add(itemProduct);
      print('Product count: ${products.length}');
    }

    return products;
  }

  static Future<void> deleteProduct(String id) async {
    await _database
        .child("product")
        .child(id)
        .remove()
        .then((value) {
          print("Menu muvaffaqiyatli o'chirildi");
        })
        .catchError((error) {
          print(error);
        });
  }
}
