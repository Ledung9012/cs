import 'package:flutter/material.dart';
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/models/store.dart';
import 'package:mobile/instance/app_instance.dart';

class Promotion {
  var id = -1;
  var promotionId = "";
  var title = "";
  var content = "";
  var discount = 0.0;
  var merchant = "";
  var code = "";

  var store_id = -1;
  var store_name = "";
  var store_image = "";
  var discount_type = "";

  Promotion.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    promotionId = jsonR.stringValue("promotion_id");
    title = jsonR.stringValue("title");
    content = jsonR.stringValue("content");
    store_id = jsonR.intValue("store_id");
    store_name = jsonR.stringValue("store_name");
    store_image = jsonR.stringValue("store_image");
    discount = jsonR.doubleValue("discount");
    discount_type = jsonR.stringValue("discount_type");
    merchant = jsonR.stringValue("merchant");
    code = jsonR.stringValue("code");


  }

  String titleDisplay (){
    var original = "[" + merchant.toUpperCase()  + "]" ;
    return title.replaceAll(original, "").trim();

  }

  String discountValue() {
    var prefix = "%";
    if (discount_type == "FIXED") {
      return discount.currencyValue();
    }
    return (discount * 100).toStringAsFixed(0) + prefix;
  }

  static List<Promotion> list(List json) {
    return json.map((entry) => Promotion.fromJson(entry)).toList();
  }

  Store store() {
    return Store(store_id, store_name, store_image);
  }

  String storeImageURL() {
    return app.cmsImgeURL() + this.store_image;
  }
}
