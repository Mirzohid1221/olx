class ProductModel {
  String? productName;
  String? productPrice;
  String? location;
  String? imageUrl;
  String? id;

  ProductModel({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.location,
    required this.imageUrl,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
    : productName = json["productName"],
      productPrice = json["productPrice"],
      location = json["location"],
      imageUrl = json['imageUrl'],
      id = json['id'];

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "productPrice": productPrice,
    "location": location,
    "imageUrl": imageUrl,
    "id": id,
  };
}
