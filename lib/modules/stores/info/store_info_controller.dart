
import 'package:get/get.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/extension/string_extension.dart';

class StoreInfoController extends GetxController{

  Order order = Order() ;

  // Tổng giá trị đơn hàng
  String totalPrice(){
    return order.billing.currencyValue();
  }

  String commission(){
    return order.pubCommission.currencyValue();
  }

  String status(){
    return "Hoàn tiền chờ duyệt" ;
  }

}