import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/home/home_controller.dart';
import 'package:mobile/services/services.dart';
import 'package:package_info/package_info.dart';

var app = AppInstance();

enum Environment {
  PRODUCTION,
  DEVELOPMENT,
  STAGING,
}

class AppInstance with WidgetsBindingObserver {
  static final AppInstance _singleton = AppInstance._internal();
  List items = [];

  AppInstance._internal();

  factory AppInstance() {
    return _singleton;
  }

  bool get devMode => !kReleaseMode;

  bool get productionMode => kReleaseMode;

  bool get isAndroid => Platform.isAndroid;

  bool get isIOS => Platform.isIOS;

  var environment = Environment.PRODUCTION;

  // Services Value-----------------------------
  var enableInternalShopping = false;
  var enableStore = false;
  var accessTradeURL = "";
  var forceUpdate = false;
  var version = "";
  var enableNewsManagement = false;
  var enableNews = false;
  var enableHelpCenter = true;
  var enableNotification = true;
  var enableCrossSearch = true;
  var enablePromotion = true;




  // Local Value-----------------------------
  var appName = "packageInfo.appName";
  var packageName = "";
  var appVersion = "";
  var buildNumber = "";

  void getAppMetadata() {}

  void initialize() {
    LaunchReview.launch();

    if (productionMode) {
      environment = Environment.PRODUCTION;
    }
  }

  set env(Environment value) {
    environment = value;
  }

  void processVersion() {
    if (appVersion != version) {
      if (forceUpdate) {
        Template.dialogInfoAction("Vui lòng cập nhật phiên bản mới", () {
          LaunchReview.launch(
              androidAppId: "com.iyaffle.rangoli", iOSAppId: "1573198040");
        });
      }
    }
  }

  void appActive() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      appVersion = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      apiRequest.msRequest(APIFunction.APP_CONFIG, Map()).then((response) {
        items = response.data;
        updateActive();
        processVersion();
      }).onError((error, stackTrace) {
        print("Update config error $error");
      });
    });
  }

  void updateActive() {
    forceUpdate = getMap("forceUpdate").boolValue("value");
    version = getMap("version").stringValue("value");
    enableNewsManagement = getMap("enableNewsManagement").boolValue("value");
  }

  void loadConfig() {
    apiRequest.msRequest(APIFunction.APP_CONFIG, Map()).then((response) {
      items = response.data;
      updateConfig();
    }).onError((error, stackTrace) {
      print("Update config error $error");
    });
  }

  void updateConfig() {
    enableInternalShopping =
        getMap("enableInternalShopping").boolValue("value");
    enableStore = getMap("enableStore").boolValue("value");
    accessTradeURL = getMap("accessTradeURL").stringValue("value");
    enableHelpCenter = getMap("enableHelpCenter").boolValue("value");
    enableNewsManagement = getMap("enableNewsManagement").boolValue("value");
    enableNews = getMap("enableNews").boolValue("value");
    enableNotification = getMap("enableNotification").boolValue("value");
    enableCrossSearch = getMap("enableCrossSearch").boolValue("value");
    enablePromotion = getMap("enablePromotion").boolValue("value");

    var homeController = Get.put(HomeController());
    homeController.loadConfigComplete = true;
  }

  Map getMap(String key) {
    if (items.firstWhere((currency) => currency["key"] == key) != null) {
      return items.firstWhere((currency) => currency["key"] == key);
    }
    return Map();
  }

  String endpoint() {
    switch (environment) {
      case Environment.DEVELOPMENT:
        return "http://apicashback.lolshop.vn";
      case Environment.STAGING:
        return "http://staging.api.save365.vn";
      case Environment.PRODUCTION:
        return "http://api.save365.vn";
    }
  }

  String cmsImgeURL() {
    switch (environment) {
      case Environment.DEVELOPMENT:
        return "http://cashback.lolshop.vn/storage/";
      case Environment.STAGING:
        return "http://staging.cms.save365.vn/storage/";
      case Environment.PRODUCTION:
        return "http://cms.save365.vn/storage/";
    }
  }

  String uploadURL() {
    switch (environment) {
      case Environment.DEVELOPMENT:
        return "http://cashback.lolshop.vn/upload/";
      case Environment.STAGING:
        return "http://staging.cms.save365.vn/upload";
      case Environment.PRODUCTION:
        return "http://api.save365.vn/upload/";
    }
  }

  String imageAppURL() {
    switch (environment) {
      case Environment.DEVELOPMENT:
        return "http://cashback.lolshop.vn/storage/";
      case Environment.STAGING:
        return "http://staging.cms.save365.vn/storage/";
      case Environment.PRODUCTION:
        return "http://cms.save365.vn/storage/";
    }
  }
}
