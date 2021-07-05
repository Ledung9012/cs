import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/models/news.dart';
import 'package:mobile/modules/news/create/ligal_view.dart';
import 'package:mobile/modules/news/news_provider.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class NewsCreateController extends GetxController {
  RxList<ComposerNode> list = List<ComposerNode>.empty().obs;
  Rx<News> item = News(-1, "").obs;
  NewsProvider _provider = NewsProvider();

  int get itemCount => list.length;

  @override
  void onInit() {
    list.value = [];
    clear();
    super.onInit();

  }

  @override
  void onReady() {
    // TODO: implement onReady
    print("TODO: implement onReady");
    if(!userInstance.acceptLigal){
      Get.dialog(LigalView());
    }
    super.onReady();
  }
  void clear() {
    list.value.clear();
    list.add(ComposerNode(type: ComposerType.TITLE, controller: this));
    list.add(ComposerNode(type: ComposerType.IMAGE, controller: this));
  }

  Widget widget(int index) {

    print("Index  : $index");
    return list[index].editting();
  }

  Widget widgetReview(int index) {
    return list[index].view();
  }

  void add(ComposerType __type) {

    var item = ComposerNode(type: __type, controller: this) ;

    print("add type : $item");
    list.add(item);
  }

  void swap(int start, int current) {
    if (start == this.list.length) {
      list.refresh();
      return;
    }
    if (start < current) {
      int end = current - 1;
      ComposerNode startItem = this.list[start];
      int i = 0;
      int local = start;
      do {
        this.list[local] = this.list[++local];
        i++;
      } while (i < end - start);
      this.list[end] = startItem;
    } else if (start > current) {
      ComposerNode startItem = this.list[start];
      for (int i = start; i > current; i--) {
        this.list[i] = this.list[i - 1];
      }
      this.list[current] = startItem;
    }
  }

  void refresh() {
    list.refresh();
  }

  void draff() {}

  void create(
      {required Function onSuccess, required Function(String) onError}) {
    ComposerNode titleNode = list[0];
    if (titleNode.isEmpty()) {
      onError("Vui lòng nhập chủ để bài viết");
      return;
    }

    ComposerNode imageNode = list[1];
    if (imageNode.isEmpty()) {
      onError("Vui lòng chọn ảnh chính cho bài viết");
      return;
    }

    var request = list.value.map((e) {
      return e.toJson();
    });

    if (list.length == 2) {
      onError("Vui lòng nhập nội dung bài viết");
      return;
    }

    var nodes = list.map((element) {
      return json.encode(element.toJson());
    }).toList();

    var request2 = json.encode(list);

    var image = imageNode.fileIndex(0);

    _provider.create(
        id: userInstance.userId,
        title: titleNode.value,
        image: image,
        content: request2,
        onSuccess: () {
          onSuccess();
        },
        onError: (error) {
          onError(error);
        });
  }

  void change() {

  }

  void goReview() {
    // var reviewController = Get.put(NewsReviewController());
    // reviewController.list.value =
    //     List.from(list.where((i) => !i.isEmpty()).toList());
    // print("review count : ${list[1].value[0].path}");
    // reviewController.reload();
    // Get.to(NewsReview());
  }
}
