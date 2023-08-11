import 'dart:io';

class ProductModel{
  String productName;
  String productStore;
  String productPrice;
  String productCatagory;
  List<File> imageList;

  ProductModel(this.productName, this.productStore, this.productPrice,
      this.productCatagory, this.imageList);


  Map<String, dynamic> toJson() => {
    'name': productName,
    'store': productStore,
    'price': productPrice,
    'cataigroy': productCatagory,
    'images': imageList.map((file) => file.path).toList(),
  };
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final store = json['store'] as String;
    final price = json['price'] as String;
    final catigory = json['cataigroy'] as String;
    final imagesPaths = (json['images'] as List<dynamic>).cast<String>();
    final images = imagesPaths.map((path) => File(path)).toList();
    return ProductModel(name,store,price,catigory, images);


  }

}