

import 'dart:convert';
import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/models/file_upload.dart';
import 'package:mobile/extension/map_extension.dart';

class News {
  int id = -1;
  String title = "";
  FileUpload image  = FileUpload() ;
  String description = "";
  List<ComposerNode> nodes  = [];
  String composerDescription = "";
  String htmlDescription = "";

  News(this.id, this.title);

  News.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    title = jsonR.stringValue("title");
    description = jsonR.stringValue("description");
    image = FileUpload.fromJson(jsonDecode(jsonR['image']));
    nodes = ComposerNode.list(json.decode(jsonR.stringValue('composer_description')));
  }

  String getString(Map data, String key)
  {
    return (data[key] != Null)? data[key] : "";
  }

  static List<News> list(List json) {
    return json.map((entry) => News.fromJson(entry)).toList();
  }

  String imageURL() {
    if (this.image != null && (this.image.path != null)) {
      return this.image.path;
    } else {
      return "";
    }
  }
}