import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/modules/account/account_controller.dart';
import 'package:mobile/modules/account/account_view.dart';
import 'package:mobile/modules/news/news_view.dart';
import 'package:mobile/modules/stores/product/product_controller.dart';
import 'package:mobile/modules/stores/product/product_view.dart';
import 'package:mobile/modules/stores/store_controller.dart';
import 'package:mobile/modules/stores/store_view.dart';

class HomeController extends GetxController {
  var tabIndex = 0;
  var _loadConfigComplete = false.obs;


  List<Widget> page = [];
  List<BottomNavigationBarItem> barItems = [];






  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  get loadConfigComplete => _loadConfigComplete.value;

  set loadConfigComplete(value) {
    loadView();
    _loadConfigComplete.value = value;
  }

  loadView() {

    Get.put(AccountController());
    Get.put(StoreController());
    Get.put(ProductController());


    page.clear();
    barItems.clear();
    page.add(NewsView());
    barItems.add(bottomNavigationBarItem(
      icon: Icons.explore_outlined,
      label: 'Bản Tin',
    ));

    if(app.enableShopping){
      page.add(ProductView());
      barItems.add(bottomNavigationBarItem(
        icon: Icons.shopping_basket_outlined,
        label: 'Shop 12K',
      ));
    }


    if(app.enableCashbackStore){
      page.add(StoreView());
      barItems.add(bottomNavigationBarItem(
        icon: Icons.featured_play_list_outlined,
        label: 'Thưởng hiệu',
      ));
    }





    page.add(AccountView());
    barItems.add(bottomNavigationBarItem(
      icon: Icons.account_box,
      label: 'Tài khoản',
    ));


    print("barItems.leobs : $barItems.leobs");
    _loadConfigComplete.refresh();


  }

  bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
