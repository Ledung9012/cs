
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/string_extension.dart';

class Product {
  int id = -1;
  String name = "";
  String image = "";
  double price = 0.0;
  String description = "";
  double originalPrice = 0.0;

  Product({required this.id, required this.name});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json.doubleValue("price");
    description = json.stringValue("description");
    originalPrice = json.doubleValue("original_price");
  }

  String priceDisplay(){
    return price.currencyValue();
  }

  String originalPriceDisplay(){
    return originalPrice.currencyValue();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['original_price'] = this.originalPrice;
    return data;
  }

  static List<Product> list(List json) {
    return json.map((entry) => Product.fromJson(entry)).toList();
  }

  String imageURL() {
    if (this.image != null && this.image.length > 0) {
      return "http://cashback.lolshop.vn/storage/" + this.image;
    } else {
      return "";
    }
  }
}
