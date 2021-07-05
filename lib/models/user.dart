
import 'package:mobile/models/store.dart';
import 'package:mobile/extension/string_extension.dart';

class CSUser {
  var id = -1;
  var username = "";
  var password = "";
  var session = "";
  var name = "";
  var email = "";
  var phone = "";
  var avatar = "";


  CSUser({required this.id});

  CSUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
  }


  static List<CSUser> list(List json) {
    return json.map((entry) => CSUser.fromJson(entry)).toList();
  }


}
