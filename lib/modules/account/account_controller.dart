import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/instance/app_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/modules/account/account_provider.dart';
import 'package:mobile/modules/account/address/address_controller.dart';
import 'package:mobile/modules/account/address/address_view.dart';
import 'package:mobile/modules/account/change_password/change_password_controller.dart';
import 'package:mobile/modules/account/change_password/change_password_view.dart';
import 'package:mobile/modules/account/login/login_controller.dart';
import 'package:mobile/modules/account/login/login_view.dart';
import 'package:mobile/modules/account/notification/notification_controller.dart';
import 'package:mobile/modules/account/notification/notification_view.dart';
import 'package:mobile/modules/news/user/news_user_controller.dart';
import 'package:mobile/modules/news/user/news_user_view.dart';
import 'package:mobile/modules/stores/order/history/order_controller.dart';
import 'package:mobile/modules/stores/order/history/order_view.dart';
import 'package:mobile/modules/transaction/transaction_controller.dart';
import 'package:mobile/modules/transaction/transaction_view.dart';
import 'package:mobile/services/upload_services.dart';

enum AccountMenuPage {
  info,
  address,
  accesstradeWallet,
  accesstradeInvest,
  changePassword,
  logout,
  bank,
  transaction,
  giftMission,
  orderHistory,
  news,
  notification
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
  var image = "".obs;
  var alreadyLogin = true.obs;

  @override
  void onReady() {
    super.onReady();
  }

  void onInit() {
    super.onInit();
    loadView();
    refresh();
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

    var item4 = AccountItem(
        image: "assets/images/ic_news.svg",
        name: "Quản lý bài viết",
        color: "406d90",
        index: AccountMenuPage.news);

    var item5 = AccountItem(
        image: "assets/images/ic_notification.svg",
        name: "Thông báo",
        color: "F09B39",
        index: AccountMenuPage.notification);

    var item6 = AccountItem(
        image: "assets/images/ic_address.svg",
        name: "Sổ địa chỉ",
        color: "2D882D",
        index: AccountMenuPage.address);

    if (app.enableStore  || app.devMode) {
      items.add(item0);
    }

    if (app.enableInternalShopping) {
      items.add(item1);
    }

    items.add(item2);

    if (app.enableNewsManagement) {
      items.add(item4);
    }




    if (app.enableNotification) {
      items.add(item5);
    }


    if (app.enableInternalShopping) {
      items.add(item6);
    }
    items.add(item3);
  }

  @override
  void refresh() {
    super.refresh();
    userInstance.alreadyLogin().then((value) {
      this.alreadyLogin.value = value;
      userInfo();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void userInfo() {
    _accountProvider.userInfo(
        id: userInstance.userId,
        success: (user) {
          name.value = user.name;
          image.value = user.avatar;
        },
        onError: (value) {});
  }

  void uploadImage(PickedFile pickerFile) {

    print("uploadImage");
    UploadServices.upload(
        pickedFile: pickerFile,
        onSuccess: (value) {



          _accountProvider.updateImage(
              id: userInstance.userId,
              image: value.path,
              success: () {
                this.image.value = value.path;
              },
              onError: (value) {



              });
          print("Upload Success");
        });
  }

  void logout() {
    userInstance.logout();
    refresh();
  }

  void logon() {
    Get.put(LoginController(
        authenSuccess: () {
          relayout();
        },
        authenFalse: (val) {}));
    Get.to(LoginView());
  }

  void relayout() {
    refresh();
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

    if (item.index == AccountMenuPage.news) {
      Get.lazyPut<NewsUserController>(() => NewsUserController());
      Get.to(() => NewsUserView());
    }

    if (item.index == AccountMenuPage.notification) {
      Get.lazyPut<NotificationController>(() => NotificationController());
      Get.to(() => NotificationView());
    }

    if (item.index == AccountMenuPage.address) {
      Get.lazyPut<AddressController>(() => AddressController());
      Get.to(() => AddressView());
    }

    if (item.index == AccountMenuPage.logout) {
      logout();
    }
  }
}
