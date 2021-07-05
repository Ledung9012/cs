import 'package:mobile/extension/map_extension.dart';

class Address {
  var districtId = -1;
  var districtName = "";
  var id = -1;
  var userId = -1;

  var wardId = -1;
  var wardName = "";
  var provinceId = -1;
  var provinceName = "";
  var name = "";
  var streetName = "";
  var streetId = "";

  var phone = "";
  var description = "";
  var display = "";

  Address.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    userId = jsonR.intValue("user_id");

    provinceId = jsonR.intValue("province_id");
    provinceName = jsonR.stringValue("province_name");

    districtId = jsonR.intValue("district_id");
    districtName = jsonR.stringValue("district_name");

    wardId = jsonR.intValue("ward_id");
    wardName = jsonR.stringValue("ward_name");

    streetId = jsonR.stringValue("street_id");
    streetName = jsonR.stringValue("street_name");

    description = jsonR.stringValue("description");
    name = jsonR.stringValue("name");
    phone = jsonR.stringValue("phone");
  }

  AddressItem province (){
   return AddressItem(id: provinceId,name: provinceName,code: "",prefix: "");
  }

  AddressItem district (){
    return AddressItem(id: districtId,name: districtName,code: "",prefix: "");
  }

  AddressItem ward (){
    return AddressItem(id: wardId,name: wardName,code: "",prefix: "");
  }

  String titleDisplay(){
    return name + " - " + phone ;
  }
  String displayDetail(){
    return description + ", " + wardName + ", " + districtName + ", " + provinceName ;
  }
  bool get isEmpty => description.isEmpty;

  Address();

  static List<Address> list(List json) {
    return json.map((entry) => Address.fromJson(entry)).toList();
  }
}

class AddressItem {
  var id = -1;
  var name = "";
  var code = "";
  var prefix = "";



  static AddressItem empty(){
    return AddressItem(id: -1, name: "", code: "", prefix: "");
  }
  AddressItem({required this.id,required this.name,required this.code,required this.prefix});

  AddressItem.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    name = jsonR.stringValue("name");
    code = jsonR.stringValue("code");
    prefix = jsonR.stringValue("prefix");
  }

  bool get isEmpty => name.isEmpty;


  String display() {
    return prefix.trim() + " " + name;
  }

  static List<AddressItem> list(List json) {
    return json.map((entry) => AddressItem.fromJson(entry)).toList();
  }
}
