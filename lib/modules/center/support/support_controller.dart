import 'package:get/get.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/modules/account/account_provider.dart';

class SupportController extends GetxController {
  AccountProvider _provider = AccountProvider();
  RxList<CSUser> _user = List<CSUser>.empty().obs;
  int get userLength => _user.length;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadData();
  }

  @override
  void onReady() {
    // TODO: implement onReady

    print("loadview");

    super.onReady();
  }

  void loadData() {
    _provider.support(success: (value) {
      _user.clear();
      _user.addAll(value);
    }, onError: (error) {});
  }

  CSUser item(int index){
    return _user[index];
  }
}