import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/instance/user_instance.dart';

class Store {
  int id = -1;
  String name = "Tiki";
  String image = "";
  String url = "";
  bool selected = false;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    url = json['url'];
  }

  Store(this.id, this.name);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

  String urlUtm(){
    return url.replaceAll("<utm_source>" ,userInstance.userId.toString());
  }
  String imageURL() {
    return app.cmsImgeURL() + this.image;
  }

  static List<Store> list(List json) {
    return json.map((entry) => Store.fromJson(entry)).toList();
  }
}
