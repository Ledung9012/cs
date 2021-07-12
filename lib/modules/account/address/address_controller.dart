import 'package:get/get.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/modules/account/address/address_add_controller.dart';
import 'package:mobile/modules/account/address/address_add_view.dart';
import 'package:mobile/modules/account/address/address_provider.dart';

class AddressController extends GetxController {
  var address = List.empty().obs;

  get length => address.length;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() {
    AddressProvider.user(
        success: (value) {
          address.clear();
          address.addAll(value);
          address.refresh();
        },
        onError: (error) {});
  }

  void goAdd() {
    Get.put(AddressAddController());

    Get.to(AddressAddView(
        addState: AddressAddType.CREATE, item: null, onComplete: (value) {
      loadData();
    }));
  }

  void detail(int index) {
    Address item = address[index];
    AddressAddController addController = Get.put(AddressAddController());
    addController.address = item;
    Get.to(AddressAddView(
      onComplete: (value) {

        loadData();

      },
      item: item,
      addState: AddressAddType.UPDATE,
    ));
  }

  Address item(int index) {
    return address[index];
  }
}
