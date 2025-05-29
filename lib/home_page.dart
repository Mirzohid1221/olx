import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:olx/Product_model.dart';
import 'package:olx/RTDBservise.dart';
import 'package:olx/akkaunt.dart';
import 'package:olx/category.dart';
import 'package:olx/product_item_widget.dart';

import 'add_item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<ProductModel> product = [];
  int _currentIndex = 0;

  _apiGetMenu() async {
    setState(() {
      isLoading = true;
    });
    var list = await RTDBservise.getProduct();
    product.clear();
    setState(() {
      product = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiGetMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leading: Icon(Icons.home, color: Colors.black87),
          backgroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          title: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: 'Что ищете?',
                      hintStyle: TextStyle(color: Colors.black45),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search, color: Colors.black54),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.black54),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  Category(),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Рекомендуем вам",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: product.length,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.9,
                          ),
                      itemBuilder: (context, index) {
                        return ProductItemWidget(
                          product: product[index],
                          onDelete: () async {
                            if (product[index].id != null) {
                              await RTDBservise.deleteProduct(
                                product[index].id!,
                              );
                              await _apiGetMenu();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Colors.blue,
        strokeColor: Colors.blueAccent,
        unSelectedColor: Colors.grey,
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(icon: Icon(Icons.home)),
          CustomNavigationBarItem(icon: Icon(Icons.add)),
          CustomNavigationBarItem(icon: Icon(Icons.person)),
        ],
        currentIndex: _currentIndex,
          onTap: (index) async {
            if (index == 1) {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemPage()),
              );
              if (result == true) {
                _apiGetMenu();
              }

              // Kechiktirib state o‘zgartiramiz
              Future.delayed(Duration(milliseconds: 100), () {
                setState(() {
                  _currentIndex = 0;
                });
              });

            } else if (index == 2) {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Akkaunt()),
              );

              Future.delayed(Duration(milliseconds: 100), () {
                setState(() {
                  _currentIndex = 0;
                });
              });

            } else if (index == 0) {
              setState(() {
                _currentIndex = 0;
              });
            }
          }
      ),
    );
  }
}
