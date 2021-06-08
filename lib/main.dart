import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/home/home_controller.dart';
import 'package:mobile/modules/home/home_view.dart';
import 'package:mobile/modules/news/news_controller.dart';

class AppPages {
  String shopping = "/shopping";
  String home = "/home";
  String intro = "/intro";
  String login = "/login";
  String news = "/news";

  static final AppPages _singleton = AppPages._internal();

  factory AppPages() {
    return _singleton;
  }

  AppPages._internal();
}

void configApp() {}

void main() async {


  app.loadConfig();
  Get.put(NewsController());
  Get.put(HomeController());

  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
      builder: EasyLoading.init(),
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
            name: AppPages().home,
            page: () {
              return HomeView();
            }),
      ],
      initialRoute: AppPages().home));

}
