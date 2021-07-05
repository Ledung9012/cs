import 'package:get/get.dart';
import 'package:mobile/models/faq.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/modules/account/account_provider.dart';

class FaqController extends GetxController {
  AccountProvider _provider = AccountProvider();
  RxList<Faq> _user = List<Faq>.empty().obs;
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
    super.onReady();
  }

  void loadData() {
    _provider.faq(success: (value) {
      _user.clear();
      _user.addAll(value);
    }, onError: (error) {});
  }

  Faq item(int index){
    return _user[index];
  }
}