import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/account/account_view.dart';
import 'package:mobile/modules/home/home_controller.dart';
import 'package:mobile/modules/news/news_view.dart';
import 'package:mobile/modules/stores/product/product_view.dart';
import 'package:mobile/modules/stores/store_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {

        return Obx(() {


          if(controller.loadConfigComplete) {
            return Scaffold(
              backgroundColor: Template.primaryColor,
              body: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      color: Template.primaryColor,
                      border: Border(
                        bottom:
                        BorderSide(width: 1, color: HexColor.fromHex("E5E5E5")),
                      )),
                  child: IndexedStack(
                    index: controller.tabIndex,
                    children:controller.page,
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Template.primaryColor,
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                elevation: 1,
                items: controller.barItems,
              ),
            );
          } else {
            return Container();
          }

        });
      },
    );
  }
}
