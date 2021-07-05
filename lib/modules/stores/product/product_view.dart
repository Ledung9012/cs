import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/product/product_controller.dart';
import 'package:mobile/modules/stores/product_detail/product_detail_controller.dart';
import 'package:mobile/modules/stores/product_detail/product_detail_view.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class ProductView extends GetView<ProductController> {
  TextEditingController _searchFieldController = TextEditingController();

  var _scrollController;

  @override
  Widget build(BuildContext context) {
    Widget addButton = GestureDetector(
        onTap: () {
          controller.goCart();
        },
        child: Icon(Icons.shopping_cart_rounded));

    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return DefaultTabController(
          length: controller.categoryLength,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  Template.sliderAppBar(
                      menu: [addButton],
                      title: "Cửa Hàng",
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
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          crossAxisCount: 2,
          crossAxisSpacing: 0.5,
          mainAxisSpacing: 0.5),
      padding: EdgeInsets.all(0),
      itemCount: product.length,
      itemBuilder: (context, index) {
        return productItem(index);
      },
    );
  }

  var product = [];

  @override
  void initState() {
    print("page : ${widget.id}");
    load();
    super.initState();
  }

  void load() {
    product.clear();
    StoreProvider provider = StoreProvider();
    provider.products(widget.id, onSuccess: (value) {
      product.addAll(value);
      setState(() {});
    }, onError: (value) {});
  }

  Widget productItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        var _detailController = Get.put(ProductDetailController());
        _detailController.product = product[index];

        Get.to(ProductDetailView(
          complete: () {
            // controller.refresh();
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.all(0),
        child: Card(
            child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: CachedNetworkImage(
                    imageUrl: product[index].imageURL(),
                  ),
                ),
              ],
            )),
            SizedBox(
              child: Container(
                height: 86,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(product[index].name,
                        maxLines: 2, style: TextStyle(height: 1.5)),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              product[index].originalPriceDisplay(),
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Template.subColor,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5),
                            ),
                          ),
                        ),
                        Container(
                            child: Text(
                          product[index].priceDisplay(),
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              height: 1.5),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
