import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/news/detail/news_detail_controller.dart';

class NewsDetailView extends GetView<NewsDetailController> {
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
                  Expanded(
                    child: Container(
                      child: composer(),
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
                                  color: Template.subColor.withOpacity(0.1)))),
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
                                style: Template.backButtonStyle),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget composer() {
    return Obx(() {
      return Container(
        child: ListView(
          shrinkWrap: true, //just set this property
          children: List.generate(controller.list.length + 1, (index) {
            if (index == controller.list.length) {
              return Container(
                height: 120,
                key: Key("ColumnFooter"),
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
