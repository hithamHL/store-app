import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/model/product_model.dart';
import 'package:store_app/ui/add_product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Map> catigory = [
    {"id": "عرض الكل", "name": "assets/images/all_element.png"},
    {"id": "تصنيف 1", "name": "assets/images/catigory_1.png"},
    {"id": "تصنيف 2", "name": "assets/images/catigory_2.png"},
    {"id": "تصنيف 3", "name": "assets/images/catigory_3.png"},
  ];
  int selectedIndex = 0;
  List<ProductModel> productsList = [];


  getAllProducts()async{
    productsList = await loadUserModelsFromPrefs();
  }

  @override
  void initState() {
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "المنتجات",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8),
            child: SizedBox(
              width: 45,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddProduct()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.all(10.0),
                  // Adjust padding as needed
                  side: BorderSide(color: Colors.grey, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16.0), // Adjust radius as needed
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "التصنيفات",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: catigory.length,
                      itemBuilder: (context, index) {
                        return getCatagoryItem(catigory[index]["id"],
                            catigory[index]["name"], index);
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 220,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/change_ori.png"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "تغيير عرض المنتجات الى الافقي",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 65, 85),
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: productsList.length > 0 ? ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return productsSection(productsList[index]);
              },
            ): Center(child: Text('لا يوجد منتجات ')),

            // FutureBuilder<List<ProductModel>>(
            //   future: loadUserModelsFromPrefs(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       print('Error: ${snapshot.error}');
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return Center(child: Text('لا يوجد منتجات '));
            //     } else {
            //       productsList= snapshot.data!;
            //       return ListView.builder(
            //         itemCount: productsList.length,
            //         itemBuilder: (context, index) {
            //           return productsSection(productsList[index]);
            //         },
            //       );
            //     }
            //   },
            // ),
          ),
        ],
      ),
    );
  }

  void _selectItem(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        _changeList(" ");
      } else if (index == 1) {
        _changeList("تصنيف 1");
      } else if (index == 2) {
        _changeList("تصنيف 2");
      } else if (index == 3) {
        _changeList("تصنيف 3");
      }
    });
  }

  ///this widget for catigory section
  Widget getCatagoryItem(name, image, index) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
          onTap: () => _selectItem(index),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: selectedIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white, //                   <--- border width here
              ), // Set the border radius
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
                    ),
                    child: Padding(
                      padding: index == 0
                          ? const EdgeInsets.all(4.0)
                          : const EdgeInsets.all(0.0),
                      child: Image.asset(
                        image,
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget productsSection(ProductModel productModel) {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.file(
              productModel.imageList[0],
              width: 70,
              height: 100,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productModel.productName,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    Text(
                      productModel.productPrice,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "دولار",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
                    ),
                    child: Text(
                      productModel.productStore,
                      style: TextStyle(color: Colors.black45, fontSize: 12),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<List<ProductModel>> loadUserModelsFromPrefs() async {
    print("########");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final productJson = prefs.getString('product');
    if (productJson != null) {
      final productList = jsonDecode(productJson) as List<dynamic>;
      print("########${productList.length}");
      return productList.map((productMap) {
        return ProductModel.fromJson(productMap);
      }).toList();
    }
    return [];
  }

  _changeList(catagory) {
    productsList = productsList.where((product) {
      return product.productCatagory == catigory;
    }).toList();
    print(  productsList.length);

  }
}
