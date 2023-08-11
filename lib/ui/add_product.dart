import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var selectedOption;
  var productName = TextEditingController();
  var productStore = TextEditingController();
  var productPrice = TextEditingController();
  List<File> imageList = [];
  List<ProductModel> products=[];

  getAllProducts()async{
    products = await loadProducts();
  }


  @override
  void initState() {
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.all(10.0),
                            // Adjust padding as needed
                            side: BorderSide(color: Colors.grey, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust radius as needed
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "اضافة منتجات",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "صور المنتجات",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageList.length,
                                itemBuilder: (context, index) {
                                  print(index);
                                  if (imageList.isNotEmpty) {
                                  return productIamge(imageList[index],index);
                                  } else {
                                    return productNull();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),

                  ///add image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        if(imageList.length < 4){

                        _pickImage(ImageSource.gallery);
                      }
                        },
                      style: ElevatedButton.styleFrom(
                        primary:
                            Theme.of(context).colorScheme.primary, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        minimumSize: Size(double.infinity, 0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_box, color: Colors.white), // Add icon
                          SizedBox(width: 8),
                          Text(
                            'اضغط لاضافة الصور',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///add text
                  addField("اسم المنتج", productName,false),

                  addField("اسم المتجر", productStore,false),

                  addField("السعر", productPrice,true),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("اسم المنتج"),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // Rounded corners
                          border: Border.all(color: Colors.grey), // Border color
                        ),
                        child: DropdownButton<String>(
                            underline: null,
                            isExpanded: true,
                            hint: Text(
                              "اسم التنصنيف",
                              style: TextStyle(color: Colors.blue),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.blue,
                            ),
                            value: selectedOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedOption = newValue!;
                              });
                            },
                            items: <String>['تصنيف 1', 'تصنيف 2', 'تصنيف 3']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      saveProductModelToPrefs();
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Theme.of(context).colorScheme.primary, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      minimumSize: Size(double.infinity, 0),
                    ),
                    child: Text(
                      'اضافة المنتج',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget productIamge(
    imageFile,
      index
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.file(imageFile), // Display the image
          Positioned(
            top: 15,
            left: 5,
            child: GestureDetector(
              onTap: () {
                _deleteImage(index);
              },
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget productNull() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border.all(color: Colors.grey),
          borderRadius:
          BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget addField(name, controller,number) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            border: Border.all(color: Colors.grey), // Border color
          ),
          child: TextField(
            textInputAction: TextInputAction.next,
            keyboardType: number ? TextInputType.number : TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none, // No default border
              hintText: name,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

   _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        // Handle the picked image file
        File imageFile = File(pickedFile.path);
        // You can display, upload, or process the image further
        setState(() {
          imageList.add(imageFile);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  _deleteImage(index){
    setState(() {
      imageList.removeAt(index);
    });

  }

  Future<void> saveProductModelToPrefs() async {
    if(productStore.text =="" &&
        productPrice.text=="" &&
        productName.text=="" &&
        selectedOption=="" &&
    imageList.isEmpty
    ){
      return;
    }

    ProductModel productModel=ProductModel(productName.text,
        productStore.text, productPrice.text, selectedOption, imageList);

    products.add(productModel);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final productJson = products.map((product) => product.toJson()).toList();

    prefs.setString('product', jsonEncode(productJson));
  }

  Future<List<ProductModel>> loadProducts() async {
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

}
