import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/modules/news/create/news_create_controller.dart';

class NewsCreateView extends GetView<NewsCreateController> {
  Widget build(BuildContext context) {
    return Container(
      color: Template.primaryColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 24, left: 12, right: 12),
                      height: 68,
                      width: double.infinity,
                      color: Template.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Review Sản Phẩm",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    controller.goReview();
                                  },
                                  child: Container(
                                    width: 48,
                                    child: Icon(
                                      Icons.preview_outlined,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: Container(
                        child: composer(context),
                      ),
                    ),
                  ),
                ],
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color:
                                        Template.subColor.withOpacity(0.1)))),
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 16),
                                height: 40,
                                width: 40,
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back_rounded),
                                  style: Template.primaryButtonStyle,
                                )),
                            Expanded(child: SizedBox()),
                            Container(
                              width: 96,
                              height: 40,
                              margin: EdgeInsets.only(right: 16),
                              child: TextButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Template.subColor, //
                                  onPrimary: Colors.white, // foreground
                                ),
                                child: Text("Lưu Nháp"),
                              ),
                            ),
                            Container(
                              width: 96,
                              height: 40,
                              margin: EdgeInsets.only(right: 16),
                              child: TextButton(
                                onPressed: () {
                                  controller.create(
                                      onSuccess: () {
                                        Template.dialogInfoAction("Thêm mới bài viết thành công", (){
                                          Get.back();
                                        });

                                      }, onError: (value) {
                                        Template.dialogError(value);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Template.primaryColor, //
                                  onPrimary: Colors.white, // foreground
                                ),
                                child: Text("Hoàn Tất"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget composer(BuildContext context) {
    return Obx(() {




      print("Re renden : ${controller.itemCount}");


      return Container(
        child: ReorderableListView(
          shrinkWrap: true, //just set this property
          onReorder: (start, current) {
            controller.swap(start, current);
          },
          children: List.generate(controller.itemCount + 1, (index) {
            if (index == controller.itemCount) {
              return Container(
                key: Key("ColumnFooter"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 18),
                      height: 60,
                      key: Key("Footer"),
                      child: GestureDetector(
                        onTap: () {},
                        child: PopupMenuButton(
                          onSelected: (value) {
                            controller.add(
                                value.toString().toEnum(ComposerType.values));
                            FocusScope.of(context).unfocus();
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: ComposerType.HEADER.description(),
                              child: Text('Tiêu đề'),
                            ),
                            PopupMenuItem<String>(
                              value: ComposerType.DESCRIPTION.description(),
                              child: Text('Đoạn mô tả'),
                            ),
                            PopupMenuItem<String>(
                              value: ComposerType.IMAGE.description(),
                              child: Text('Hình ảnh'),
                            ),
                            PopupMenuItem<String>(
                              value: ComposerType.LIST.description(),
                              child: Text('đoạn danh sách'),
                            ),
                          ],
                          child: Container(
                            width: 200,
                            margin: EdgeInsets.only(top: 12),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 12),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: Template.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "Thêm nội dung",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 480,
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: Colors.white,
                key: Key(controller.list[index].key),
                child: controller.widget(index),
              );
            }
          }),
        ),
      );
    });
  }
}
