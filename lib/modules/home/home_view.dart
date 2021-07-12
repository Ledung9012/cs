import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/home/home_controller.dart';
import 'package:mobile/modules/news/news_controller.dart';





class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  HomeController? controller;

  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.resumed){

      print("Appstate : resumed");
      app.appActive();
    }

    if(state == AppLifecycleState.paused){
      print("Appstate : paused");

    }

    if(state == AppLifecycleState.inactive){
      print("Appstate : inactive");

    }

    if(state == AppLifecycleState.detached){
      print("Appstate : detached");

    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        this.controller = controller;
        if (controller.devMode) {
          if (controller.selectEndpoint.value) {
            return home();
          } else {
            return environment();
          }
        } else {
          return home();
        }
      },
    );
  }

  Widget environment() {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 24, bottom: 24),
                child: Text(
                  "Select environment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  app.env = Environment.PRODUCTION;
                  controller!.selectEndpoint.value = true;
                  app.loadConfig();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, left: 16, bottom: 12),
                  child: Text(
                    "Production ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  app.env = Environment.STAGING;
                  controller!.selectEndpoint.value = true;
                  app.loadConfig();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, left: 16, bottom: 12),
                  child: Text(
                    "Staging ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  app.env = Environment.DEVELOPMENT;
                  controller!.selectEndpoint.value = true;
                  app.loadConfig();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(top: 12, left: 16, bottom: 12),
                  child: Text(
                    "Development",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget home() {

    Get.put(NewsController());

    return Obx(() {
      if (controller!.loadConfigComplete) {
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
                index: controller!.tabIndex,
                children: controller!.page,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Template.primaryColor,
            onTap: controller!.changeTabIndex,
            currentIndex: controller!.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            elevation: 1,
            items: controller!.barItems,
          ),
        );
      } else {
        return sloganView();
      }
    });
  }

  Widget sloganView() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Template.primaryColor,
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: null /* add child content here */,
          ),
          Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 120),
                width: 160,
                child: Image(
                  image: AssetImage("assets/images/slogen.png"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
