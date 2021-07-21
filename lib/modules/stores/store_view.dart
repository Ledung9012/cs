import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/modules/account/login/login_controller.dart';
import 'package:mobile/modules/account/login/login_view.dart';
import 'package:mobile/modules/stores/store_controller.dart';
import 'package:mobile/modules/stores/store_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return DefaultTabController(
          length: controller.categoryCount,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  Template.sliderAppBar(
                      menu: [],
                      title: "Thương hiệu hoàn tiền",
                      items: controller.categories
                          .map((item) => item.name)
                          .toList())
                ];
              },
              body: TabBarView(
                children: controller.categories
                    .map((item) => ItemView(item.id))
                    .toList(),
              ),
            ),
          ),
        );
      }),
    );
  }

  TextStyle selectedStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);
  TextStyle unSelectedStyle = TextStyle(color: Colors.white54, fontSize: 16);

  Widget buildCategory() {
    return Expanded(
      child: Container(
          width: double.infinity,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryCount,
                itemBuilder: (context, index) {
                  var color = (index != 0) ? Colors.white54 : Colors.white;
                  return Container(
                    padding: EdgeInsets.only(
                      left: 0,
                      right: 12,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller.selectIndex(index);
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        child: Center(
                            child: Text(
                          controller.item(index).name,
                          style: (index == controller.selectedIndex)
                              ? selectedStyle
                              : unSelectedStyle,
                        )),
                      ),
                    ),
                  );
                });
          })),
    );
  }

  Widget tabItem(String value) {
    return Container(margin: EdgeInsets.only(bottom: 12), child: Text(value));
  }
}

class ItemView extends StatefulWidget {
  int id = -1;

  ItemView(this.id);

  @override
  _State createState() => _State();
}

class _State extends State<ItemView> {
  var stores = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(0),
      itemCount: stores.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.48,
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0),
      itemBuilder: (BuildContext context, int index) {
        return buildCell(index);
      },
    );
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() {
    stores.clear();
    StoreProvider provider = StoreProvider();
    provider.index(widget.id, onSuccess: (value) {
      setState(() {
        stores.addAll(value);
        print("---------------${stores.length}");
      });
    }, onError: (value) {});
  }

  void _launchURL(url) async {

    print("GO TO LINK : $url");
    launch(url, forceSafariVC: false);
  }



  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () {
        var item = this.stores[index];

        if (!userInstance.logged) {
          Template.dialogInfoAction("Vui lòng đăng nhập để đươc hoàn tiền.",
              () {
            Get.put(
                LoginController(authenSuccess: () {}, authenFalse: (val) {}));
            Get.to(LoginView());
          });
        } else {
          print("Go");
          _launchURL(item.urlUtm());
        }


        // Get.bottomSheet(
        //   StoreInfoView(
        //     store: item,
        //   ),
        //   isScrollControlled: true,
        //   ignoreSafeArea: false,
        // );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(width: 1, color: Colors.black12),
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: stores[index].imageURL(),
            ),
          ),
        ),
      ),
    );
  }
}
