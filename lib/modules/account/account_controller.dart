import 'package:get/get.dart';
import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/modules/account/account_provider.dart';
import 'package:mobile/modules/account/change_password/change_password_controller.dart';
import 'package:mobile/modules/account/change_password/change_password_view.dart';
import 'package:mobile/modules/stores/order/history/order_controller.dart';
import 'package:mobile/modules/stores/order/history/order_view.dart';
import 'package:mobile/modules/transaction/transaction_controller.dart';
import 'package:mobile/modules/transaction/transaction_view.dart';

enum AccountMenuPage {
  info,
  accesstradeWallet,
  accesstradeInvest,
  changePassword,
  logout,
  bank,
  transaction,
  giftMission,
  orderHistory,
}

class AccountItem {
  var image = "";
  var name = "";
  var color = "";

  AccountMenuPage index = AccountMenuPage.info;

  AccountItem(
      {required this.image,
      required this.name,
      required this.color,
      required this.index});
}

class AccountController extends GetxController {
  AccountProvider _accountProvider = AccountProvider();

  var items = [];

  var name = "".obs;
  var alreadyLogin = true.obs;

  @override
  void onReady() {
    super.onReady();
  }

  void onInit() {
    super.onInit();
    loadView();
  }

  void loadView() {
    var item0 = AccountItem(
      image: "assets/images/ic_wallet_cashback.svg",
      name: "Ví hoàn tiền mua sắm",
      color: "2D882D",
      index: AccountMenuPage.transaction,
    );

    var item1 = AccountItem(
      image: "assets/images/ic_history.svg",
      name: "Lịch sử mua hàng",
      color: "27b4f5",
      index: AccountMenuPage.orderHistory,
    );

    var item2 = AccountItem(
      image: "assets/images/ic_shield.svg",
      name: "Thay đổi mật khẩu",
      color: "ffc71e",
      index: AccountMenuPage.changePassword,
    );

    var item3 = AccountItem(
        image: "assets/images/ic_logout.svg",
        name: "Đăng xuất",
        color: "fd3731",
        index: AccountMenuPage.logout);

    if (app.enableCashbackStore) {
      items.add(item0);
    }

    if (app.enableShopping) {
      items.add(item1);
    }

    items.add(item2);
    items.add(item3);
  }

  @override
  void refresh() {
    super.refresh();
    // userInstance.alreadyLogin().then((value) {
    //   this.alreadyLogin.value = value;
    // });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void userInfo() {
    // userInstance.alreadyLogin().then((value) {
    //   _accountProvider.userInfo(
    //       id: userInstance.userId,
    //       success: (user) {
    //         name.value = user.name;
    //       });
    // });
  }

  void logout() {
    // userInstance.logout();
    // refresh();
  }

  void logon() {
    // Get.put(LoginController());
    // Get.to(LoginScreen());
  }

  void select(int index) {
    var item = items[index];
    if (item.index == AccountMenuPage.orderHistory) {
      var orderController = Get.put(OrderController());
      orderController.loadOrder();
      Get.to(OrderView());
    }

    if (item.index == AccountMenuPage.changePassword) {
      var orderController = Get.put(ChangePasswordController());
      Get.to(ChangePasswordView());
    }

    if (item.index == AccountMenuPage.transaction) {
      Get.lazyPut<TransactionController>(() => TransactionController());
      Get.to(() => TransactionView());
    }
  }
}
