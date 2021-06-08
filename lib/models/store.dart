class Store {
  int id  = -1;
  String name = "Tiki";
  String image = "";
  String logo = "";
  String url = "";
  bool selected   = false;

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ;
    logo = json['logo'] ;
    url = json['url'] ;
  }

  Store(this.id, this.name);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

  String imageURL (){
    if(this.image.length > 0) {
      return "http://cashback.lolshop.vn/storage/" + this.image;
    }else {
      return this.logo;
    }
  }

  static List<Store> list(List json) {
    return json.map((entry) => Store.fromJson(entry)).toList();
  }

}