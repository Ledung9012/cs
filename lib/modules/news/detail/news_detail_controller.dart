

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/modules/news/news_provider.dart';
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class NewsDetailController extends GetxController{

  RxList<ComposerNode> list = List<ComposerNode>.empty().obs;
  NewsProvider _provider = NewsProvider();
  @override
  void onInit() {

    super.onInit();
  }

  Widget widget(int index) {
    print("detail count : ${list.length}");

    return list[index].view();
  }

  void reload(){
    list.refresh();
  }
}