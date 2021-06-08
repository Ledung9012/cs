import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/modules/stores/cart/cart_instance.dart';
import 'package:mobile/modules/stores/store_provider.dart';


class ProductController extends GetxController with StateMixin {

  var productCount = cart.products.length.obs;

  ScrollController categoryScrollController = ScrollController();
  StoreProvider _provider = StoreProvider();
  RxList<Product> _products = List<Product>.empty().obs;
  RxList<Category> _categories = List<Category>.empty().obs;

  var _categorySelected = 0.obs;

  int get categoryLength => _categories.length;

  int get productLength => _products.length;

  int get categorySelected => _categorySelected.value;

  Category categoryIndex(int index) => _categories[index];

  Product productIndex(int index) => _products[index];

  void selectCategory(int index) {
    int reIndex  = index ;
    if(reIndex == categoryLength){
      reIndex = 0 ;
    }

    if(reIndex < 0){
      reIndex = categoryLength -1 ;
    }
    _categorySelected.value = reIndex;
    _categories.refresh();
    getProduct();
  }

  void next(){
    selectCategory(_categorySelected.value + 1);

  }

  void  refresh(){

    productCount.value = cart.products.length;
    productCount.refresh();
  }
  void previous(){
    selectCategory(_categorySelected.value -1);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void onInit() {
    super.onInit();
    getCategory();




  }

  void loadMore(String value) {}

  void onChange(String value) {}

  void getCategory() {
    _provider.category(onSuccess: (value){
      _categories.clear();
      _categories.add(Category(-1, "Tất Cả"));
      _categories.addAll(value);

      selectCategory(0);
    }, onError: (value){

    });
  }

  void getProduct() {
    _products.clear();
    _provider.products(_categories[categorySelected].id,onSuccess: (value) {
      _products.addAll(value);
      _products.refresh();
    },onError: (value){

    });
  }

}
