import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/Product_model.dart';
import 'package:olx/RTDBservise.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  bool isLoading = false;
  TextEditingController _producktNameController = TextEditingController();
  TextEditingController _producktPriceController = TextEditingController();
  TextEditingController _productLocationController = TextEditingController();
  TextEditingController _productImageUrlController = TextEditingController();
  File? image;
  final ImagePicker picker = ImagePicker();

  Future _getCameraImage() async {
    final picedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picedFile != null) {
        image = File(picedFile.path);
      }
    });
  }

  Future _getGalleryImage() async {
    final picedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picedFile != null) {
        image = File(picedFile.path);
      }
    });
  }

  void createMenu() {
    String name = _producktNameController.text.trim().toString();
    String price = _producktPriceController.text.trim().toString();
    String location = _productLocationController.text.trim().toString();
    String imageUrl = _productImageUrlController.text.trim().toString();
    if (name.isEmpty || price.isEmpty) {
      return;
    }
    _apiCreateProductItem(name, price, location, imageUrl);
  }

  void _apiCreateProductItem(
      String name,
      String price,
      String location,
      String imageUrl,
      ) {
    setState(() {
      isLoading = true;
    });
    var product = ProductModel(
      productName: name,
      productPrice: price,
      location: location,
      imageUrl: imageUrl,
    );
    RTDBservise.addProduct(product).then(
          (value) => {
        setState(() {
          isLoading = false;
        }),
        Navigator.of(context).pop(true),
      },
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: _getCameraImage,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt, size: 40),
                    SizedBox(height: 8),
                    Text('Kamera'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _getGalleryImage,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.photo_library, size: 40),
                    SizedBox(height: 8),
                    Text('Galereya'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Добавить продукт",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(16),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showBottomSheet,
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade400,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: image != null
                        ? ClipOval(
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                        width: 180,
                        height: 180,
                      ),
                    )
                        : Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    "Загрузите\nфото продукта",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  TextField(
                    controller: _productImageUrlController,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: "Введите URL изображения",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.image, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _producktNameController,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: "Введите название продукта",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.shopping_bag, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _producktPriceController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: "Введите цену продукта",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _productLocationController,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: "Введите локацию продукта",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                createMenu();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Разместить продукт",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
