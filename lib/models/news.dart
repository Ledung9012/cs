import 'dart:convert';

import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/models/composer/composer_node.dart';
import 'package:mobile/models/file_upload.dart';

class News {
  int id = -1;
  String title = "";
  FileUpload image = FileUpload();
  String description = "";
  List<ComposerNode> nodes = [];
  String composerDescription = "";
  String htmlDescription = "";
  int userId = -1;
  String userName = "";
  String userImage = "";

  News(this.id, this.title);

  News.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    userId = jsonR.intValue("user_id");
    title = jsonR.stringValue("title");
    userName = jsonR.stringValue("user_name");
    userImage = jsonR.stringValue("user_image");
    description = jsonR.stringValue("description");
    image = FileUpload.fromJson(jsonDecode(jsonR['image']));
    nodes = ComposerNode.list(
        json.decode(jsonR.stringValue('composer_description')));

    var titleNode  = nodes[0];
    titleNode.image =  userImage ;
    titleNode.name = userName;
    titleNode.date = "12-12-2020";

  }

  String getString(Map data, String key) {
    return (data[key] != Null) ? data[key] : "";
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
