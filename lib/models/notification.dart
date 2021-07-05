import 'dart:convert';

import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/models/product.dart';

enum TransactionType { PRODUCT, NEWS_SUCCESS, NONE }

class SNotification {
  int id = -1;
  String name = "";
  TransactionType type = TransactionType.NONE;

  var content;

  SNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json.stringValue("type").toEnum(TransactionType.values);
    if (type == TransactionType.PRODUCT) {
      var jsonContent = jsonDecode(json["content"]);
      content = Product.fromJson(jsonContent);
    }
  }

  String itemName() {
    return content.name;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }

  static List<SNotification> list(List json) {
    return json.map((entry) => SNotification.fromJson(entry)).toList();
  }
}
