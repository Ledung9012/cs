import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/news/detail/news_detail_controller.dart';
import 'package:mobile/modules/news/detail/news_detail_view.dart';
import 'package:mobile/modules/news/news_controller.dart';
import 'package:mobile/modules/news/news_provider.dart';

class NewsView extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {

    Widget addButton = GestureDetector(
        onTap: () {
          controller.create();
        },
        child: Icon(
          Icons.post_add_rounded,
          size: 24,
        ));

    Widget bookMark = GestureDetector(
        onTap: () {
          controller.favorToggle();
        },
        child: Icon(
          Icons.bookmark_border_rounded,
          size: 24,
        ));
    Widget separator = SizedBox(
      width: 12,
    );


    List<Widget> child = [] ;
    if(app.enableNewsManagement){
      child.add(addButton);
      child.add(separator);

    }

    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        print(
            "build  controller.categories.length ${controller.initalTabbarIndex()}");
        return DefaultTabController(
          length: controller.categoryLength,
          initialIndex: controller.initalTabbarIndex(),
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  Template.sliderAppBar(
                      title: "Giới thiệu sản phẩm",
                      items: controller.categories
                          .map((item) => item.name)
                          .toList(),
                      menu:child)
                ];
              },
              body: TabBarView(
                children: controller.categories
                    .map((item) => ItemView(
                          id: item.id,
                          favor: controller.favor.value,
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ItemView extends StatefulWidget {
  int id = -1;

  bool favor = false;

  ItemView({required this.id, required this.favor});

  @override
  _State createState() => _State();
}

class _State extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index) {
          return newsItem(index);
        });
  }

  var _news = [];

  @override
  void initState() {
    print("page : ${widget.id}");
    getNewst();
    super.initState();
  }

  void getNewst() {
    if (widget.favor) {
    } else {
      NewsProvider _provider = NewsProvider();
      _news.clear();
      _provider.index(widget.id, (value) {
        _news.addAll(value);
        setState(() {});
      }, (error) {});
    }
  }

  Widget newsItem(int index) {
    return GestureDetector(
      onTap: () {
        var detailController = Get.put(NewsDetailController());
        detailController.list.clear();
        detailController.list.addAll(_news[index].nodes);
        Get.to(NewsDetailView());
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 4),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AspectRatio(
                        aspectRatio: 1.48,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: CachedNetworkImage(
                                imageUrl: _news[index].imageURL())))),
              ),
              Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Text(
                    _news[index].title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  padding: EdgeInsets.only(left: 16, top: 4, bottom: 16)),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: double.infinity,
                height: 1,
                color: Template.subColor.withOpacity(0.1),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, top: 12, bottom: 16),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 28,
                          height: 28,
                          child: CachedNetworkImage(
                            imageUrl: _news[index].userImage,
                          ),
                        )),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          _news[index].userName,
                          style:
                              TextStyle(color: Template.subColor, fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(
                        "12-12-2021",
                        style:
                            TextStyle(color: Template.subColor, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
