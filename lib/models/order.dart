import 'package:flutter/material.dart';
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/string_extension.dart';

enum OrderCommistionStatus {
  SUCCESS,
  REJECT,
  PENDING,
}

class OrderCreateRequest{
  int userId = 0 ;
  String name = "" ;
  String phone = "" ;
  String address = "" ;
  dynamic products ;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['products'] = this.products;

    return data;
  }

}

class Order {
  int id = -1;
  int userId = -1;
  double billing = 0.0;
  double pubCommission = 0.0;
  int storeId = -1;
  String merchant = "";
  OrderCommistionStatus status = OrderCommistionStatus.PENDING;
  String salesTime = "";
  String createdAt = "";

  Order();

  Order.fromJson(Map<String, dynamic> jsonR) {
    id = jsonR.intValue("id");
    userId = jsonR.intValue("user_id");
    billing = jsonR.doubleValue("billing");
    pubCommission = jsonR.doubleValue("pub_commission");
    merchant = jsonR.stringValue("merchant");
    status = jsonR.stringValue("status").toEnum(OrderCommistionStatus.values);
    createdAt = jsonR.stringValue("created_at");
  }

  static List<Order> list(List json) {
    return json.map((entry) => Order.fromJson(entry)).toList();
  }

  String billingDisplay() {
    return billing.currencyValue();
  }

  String commissionDisplay() {
    return pubCommission.currencyValue();
  }

  String orderName() {
    return " - Đơn hàng " + merchant.toUpperCase();
  }

  String dateDisplay() {
    if (DateTime.tryParse(createdAt) != null) {
      var date = DateTime.parse(createdAt);
      return date.stringValue();
    }
    return "";
  }

  String statusDisplay() {
    switch (status) {
      case OrderCommistionStatus.SUCCESS:
        return "Thành công";
      case OrderCommistionStatus.PENDING:
        return "Đang xử lý";
      case OrderCommistionStatus.REJECT:
        return "Từ chối";
    }
  }

  Color statusColor() {
    switch (status) {
      case OrderCommistionStatus.SUCCESS:
        return Colors.green;
      case OrderCommistionStatus.PENDING:
        return Colors.orangeAccent;
      case OrderCommistionStatus.REJECT:
        return Colors.red;
    }
  }
}
