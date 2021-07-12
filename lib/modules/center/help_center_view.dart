import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/center/contact/contact_controller.dart';
import 'package:mobile/modules/center/contact/contact_view.dart';
import 'package:mobile/modules/center/faq/faq_view.dart';
import 'package:mobile/modules/center/help_center_controller.dart';
import 'package:mobile/modules/center/support/support_view.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                Template.sliderAppBar(title: "hỗ trợ khách hàng",items: ["Trực tuyến", "Câu hỏi thường gặp","Liên hệ"],menu: []),
              ];
            },
            body: TabBarView(
              children: [
                SupportView(),
                FAQView(),
                ContactView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
