import 'package:flutter/material.dart';
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/string_extension.dart';

class Faq {
  var id = -1;
  var title = "";
  var content = "";

  Faq.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    title = jsonR.stringValue("title");
    content = jsonR.stringValue("content");
  }

  static List<Faq> list(List json) {
    return json.map((entry) => Faq.fromJson(entry)).toList();
  }
}
