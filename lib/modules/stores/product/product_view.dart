import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/cart/cart_controller.dart';
import 'package:mobile/modules/stores/cart/cart_view.dart';
import 'package:mobile/modules/stores/product/product_controller.dart';
import 'package:mobile/modules/stores/product_detail/product_detail_controller.dart';
import 'package:mobile/modules/stores/product_detail/product_detail_view.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ProductView extends GetView<ProductController> {
  TextEditingController _searchFieldController = TextEditingController();

  var _scrollController;

  @override
  Widget build(BuildContext context) {
    controller.refresh();

    _scrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    return Stack(
      children: [
        GestureDetector(
          onHorizontalDragEnd: (val) {
            if (val.primaryVelocity! < 0) {
              controller.next();
            } else {
              controller.previous();
            }
          },
          child: Container(
            color: Template.backgroundColor,
            child: CustomScrollView(
              slivers: [
                SliverStickyHeader(
                  header: Container(
                      padding: EdgeInsets.only(top: 24, left: 12, right: 12),
                      height: 60,
                      width: double.infinity,
                      color: Template.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cửa hàng 12K",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      )),
                ),
                SliverStickyHeader(
                  sticky: true,
                  header: buildCategory(),
                  sliver: sliverGrid(),
                )
              ],
            ),
          ),
        ),
        cart()
      ],
    );
  }

  Widget cart() {
    return Obx(() {
      if (controller.productCount > 0) {
        return Positioned(
            bottom: 16,
            right: 16,
            width: 48,
            height: 48,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {

                print("Go to cart ");
                var cart_ = Get.put(CartController());
                cart_.refresh();
                Get.to(CartView((){

                }));
              },
              child: Container(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.redAccent[400],
                ),
              ),
            ));
      } else {
        return Container();
      }
    });
  }

  Widget sliverGrid() {
    return Obx(() {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 0.5,
          crossAxisSpacing: 0.5,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return productItem(index);
        }, childCount: controller.productLength),
      );
    });
  }

  TextStyle selectedStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);
  TextStyle unSelectedStyle = TextStyle(color: Colors.white54, fontSize: 16);

  Widget buildCategory() {
    return Container(
        color: Template.primaryColor,
        height: 48,
        width: double.infinity,
        child: Obx(() {
          return ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoryLength,
              itemBuilder: (context, index) {
                var color = (index != 0) ? Colors.white54 : Colors.white;

                return Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 12,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: GestureDetector(
                      onTap: () {
                        print("Selected Category index");

                        _scrollController.scrollToIndex(index,
                            duration: Duration(seconds: 1),
                            preferPosition: AutoScrollPosition.middle);
                        controller.selectCategory(index);
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          controller.categoryIndex(index).name,
                          style: (index == controller.categorySelected)
                              ? selectedStyle
                              : unSelectedStyle,
                        )),
                      ),
                    ),
                  ),
                );
              });
        }));
  }

  Widget buildInputField() {
    return Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.search,
                enableSuggestions: false,
                autocorrect: false,
                onSubmitted: (text) {
                  controller.loadMore(text);
                },
                onChanged: (value) {
                  controller.onChange(value);
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Nhập tên sản phẩm bạn cần tìm"),
                controller: _searchFieldController,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                        Border.all(width: 1.48, color: Template.primaryColor)),
                width: 48,
                margin: EdgeInsets.all(4),
                child: TextButton(
                    onPressed: () {},
                    child: SvgPicture.asset(
                      "assets/images/ic_filter.svg",
                      height: 24,
                      width: 24,
                      color: Template.primaryColor,
                    )))
          ],
        ));
  }

  Widget buildGridView() {
    return Obx(() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3),
        padding: EdgeInsets.all(0),
        // shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return productItem(index);
        },
      );
    });
  }

  /*

  * */
  Widget productItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        var _detailController = Get.put(ProductDetailController());
        _detailController.product = controller.productIndex(index);

        Get.to(ProductDetailView(
          complete: () {
            controller.refresh();
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
                    imageUrl: controller.productIndex(index).imageURL(),
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
                    Text(controller.productIndex(index).name,
                        maxLines: 2, style: TextStyle(height: 1.5)),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              controller
                                  .productIndex(index)
                                  .originalPriceDisplay(),
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
                          controller.productIndex(index).priceDisplay(),
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
