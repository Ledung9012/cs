

import 'dart:convert';
import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/models/file_upload.dart';
import 'package:mobile/extension/map_extension.dart';

class Bank {
  int id = -1;
  String name = "";
  String shortName = "";
  String code = "";

  Bank.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    name = jsonR.stringValue("name");
    shortName = jsonR.stringValue("short_name");
    code = jsonR.stringValue("code");
  }

  static List<Bank> list(List json) {
    return json.map((entry) => Bank.fromJson(entry)).toList();
  }
}