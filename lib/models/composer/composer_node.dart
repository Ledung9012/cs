import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/models/composer/composer_description.dart';
import 'package:mobile/models/composer/composer_header.dart';
import 'package:mobile/models/composer/composer_image.dart';
import 'package:mobile/models/composer/composer_image_group.dart';
import 'package:mobile/models/composer/composer_title.dart';
import 'package:mobile/models/file_upload.dart';
import 'package:mobile/modules/news/create/news_create_controller.dart';

enum ComposerType { HEADER, DESCRIPTION, LIST, IMAGES, IMAGE, TITLE }

extension Com on ComposerType {
  String description() {
    return this.toString().split(".")[1];
  }
}

class ComposerNode {
  InputDecoration completeStyle = InputDecoration(border: InputBorder.none);
  InputDecoration editingStyle = InputDecoration(hintText: "Thêm mới tiêu để ");

  TextEditingController headerEditController = TextEditingController();
  String key = generateRandomString(12);
  ComposerType type = ComposerType.HEADER;
  NewsCreateController controller = NewsCreateController();
  dynamic value;

  var name = "" ;
  var image = "";
  var date = "" ;

  ComposerNode({required this.type, required this.controller});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type.description();
    data['value'] = value;
    if (type == ComposerType.IMAGE) {
      // data['value']  =  value.map((element){return element.toJson();});
    }
    return data;
  }

  String getString(Map data, String key) {
    return (data[key] != Null) ? data[key] : "";
  }

  static List<ComposerNode> list(List json) {
    return json.map((entry) => ComposerNode.fromJson(entry)).toList();
  }

  ComposerNode.fromJson(Map<String, dynamic> jsonR) {
    type = jsonR['type'].toString().toEnum(ComposerType.values);
    value = jsonR["value"];
    if (type == ComposerType.IMAGE) {
      value = FileUpload.list(jsonR["value"]);
    }
  }

  Widget view() {
    switch (type) {
      case ComposerType.HEADER:
        return headerView();
      case ComposerType.DESCRIPTION:
        return descriptionView();
      case ComposerType.IMAGES:
        return imagesView();
      case ComposerType.TITLE:
        return titleView();
      case ComposerType.IMAGE:
        return imageView();
      case ComposerType.LIST:
        return imageView();
    }
    return Container();
  }

  Widget editting() {
    switch (type) {
      case ComposerType.HEADER:
        return headerEditing();
      case ComposerType.DESCRIPTION:
        return desciptionEditting();
      case ComposerType.HEADER:
        return this.headerEditing();
      case ComposerType.IMAGE:
        return this.imageEdit();
      case ComposerType.IMAGES:
        return imagesEditing();
      case ComposerType.TITLE:
        return titleEdit();
      case ComposerType.LIST:
        return imageView();
    }
    return Container();
  }

  bool isEmpty() {
    bool result = true;
    switch (type) {
      case ComposerType.HEADER:
        result = (value == null) || (value as String).trim().length == 0;
        break;
      case ComposerType.DESCRIPTION:
        result = (value == null) || (value as String).trim().length == 0;
        break;
      case ComposerType.IMAGES:
        result = (value == null) || ((value as List).length == 0);
        break;
      case ComposerType.TITLE:
        result = (value == null) || (value as String).trim().length == 0;
        break;
      case ComposerType.IMAGE:
        result = (value == null) || (value as List).length == 0;
        break;
      case ComposerType.LIST:
        result = (value == null) || (value as List).length == 0;
        break;
    }
    return result;
  }

  String fileIndex(int index) {
    return json.encode((value[index] as FileUpload).toJson());
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
