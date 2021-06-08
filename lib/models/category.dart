


class Category {
  int id  = -1;
  String name = "";

  Category(this.id, this.name);
  double firstaccesstradeRatio = 0.0;
  double accesstradeRatio = 0.0;

  Category.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];

    if(json['first_accesstrade_ratio'] != null) {
      firstaccesstradeRatio = json['first_accesstrade_ratio'].toDouble();
    }

    if(json['accesstrade_ratio'] != null) {
      accesstradeRatio = json['accesstrade_ratio'].toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }

  static List<Category> list(List json) {
    return json.map((entry) => Category.fromJson(entry)).toList();
  }


}