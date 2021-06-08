
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/map_extension.dart';

class FileUpload {
  String fieldname  = "";
  String originalname  = "";
  String destination  = "";
  String path = "" ;


  FileUpload();

  FileUpload.fromJson(Map<String, dynamic> json) {
    fieldname = json.stringValue("fieldname");
    originalname = json.stringValue('originalname');
    destination = json.stringValue('destination');
    path = json.stringValue('path');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalname'] = this.originalname;
    data['destination'] = this.destination;
    data['path'] = this.path;
    return data;
  }

  static List<FileUpload> list(List json) {
    return json.map((entry) => FileUpload.fromJson(entry)).toList();
  }

}



/*
flutter: {"message":"","data":[{"fieldname":"media","originalname":"image_picker_C1D7B14F-AF90-4F0B-9762-292449302295-4951-00000457FFC61B5E.jpg","encoding":"7bit","mimetype":"application/octet-stream","destination":"/home/accesstrade/storage/upload/2021-5-9","filename":"9fH-1620575110616-image_picker_C1D7B14F-AF90-4F0B-9762-292449302295-4951-00000457FFC61B5E.jpg","path":"http://accesstrade.lolshop.vn/storage/upload2021-5-9/9fH-1620575110616-image_picker_C1D7B14F-AF90-4F0B-9762-292449302295-4951-00000457FFC61B5E.jpg","size":526679}],"value":"","success":1,"code":""}

 */