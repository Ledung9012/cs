import 'package:get/get.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class OrderController extends GetxController {
  RxList<Order> _orders = List<Order>.empty().obs;

  int get orderLength => _orders.length;

  @override
  void onInit() {
  }



  void loadOrder() {
    _orders.clear();
    StoreProvider.orderHistory(
      userId: 2,
      success: (values) {
        _orders.addAll(values);
      },
      onError: (error) {
        print("");
      },
    );
  }


  Order item(int index)
  {
    return _orders[index];
  }

}
