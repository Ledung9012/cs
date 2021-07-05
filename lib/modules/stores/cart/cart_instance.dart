import 'package:get/get.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/modules/stores/product/product_controller.dart';
import 'package:mobile/extension/string_extension.dart';
import '';
var cart = CartInstance();
extension ListUtils<T> on List<T> {
  num sumBy(num f(T element)) {
    num sum = 0;
    for(var item in this) {
      sum += f(item);
    }
    return sum;
  }
}

class CartInstance {
  static final CartInstance _singleton = CartInstance._internal();

  List<Product> products = [];

  factory CartInstance() {
    return _singleton;
  }

  CartInstance._internal();

  void add(Product item) {

    ProductController productController =  Get.put(ProductController()) ;
    productController.refresh();

    bool alreadyExists = false;
    for (var s in products) {
      if (s.id == item.id) {
        alreadyExists = true;
        break;
      }
    }
    if (!alreadyExists) {
      products.add(item);
    }

  }


  get empty => (products.length == 0);

  void remove(int index){
    products.removeAt(index);
    ProductController productController =  Get.put(ProductController()) ;
    productController.refresh();
  }

  void removeAll(){
    products.clear();
    ProductController productController =  Get.put(ProductController()) ;
    productController.refresh();
  }

  String  sumDisplay(){
    return products.sumBy((point) => point.price).toDouble().currencyValue();
  }
}
