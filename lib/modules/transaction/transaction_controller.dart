import 'package:get/get.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/transaction.dart';
import 'package:mobile/modules/transaction/history/transaction_history_controller.dart';
import 'package:mobile/modules/transaction/history/transaction_history_view.dart';
import 'package:mobile/modules/transaction/transaction_provider.dart';
import 'package:mobile/modules/transaction/withdraw/withdraw_controller.dart';
import 'package:mobile/modules/transaction/withdraw/withdraw_view.dart';

class TransactionController extends GetxController {
  var _provider = TransactionProvider();
  var transactionSummary = TransactionSummary().obs;

  String get available => transactionSummary.value.available.currencyValue();

  String get withdraw => transactionSummary.value.withdraw.currencyValue();

  String get cashback => transactionSummary.value.cashback.currencyValue();

  String get withdraw_process => transactionSummary.value.withdraw_process.currencyValue();
  String get cashback_process => transactionSummary.value.cashback_process.currencyValue();


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void summary() {
    _provider.summary(
        userId: userInstance.userId,
        onSuccess: (value) {
          transactionSummary.value = value;
        },
        onError: (value) {});
  }

  @override
  void onInit() {
    super.onInit();
    summary();
  }

  void goHistory() {
    Get.lazyPut<TransactionHistoryController>(
        () => TransactionHistoryController());
    Get.to(() => TransactionHistoryView());
  }

  void goMission() {}

  void goWithdraw() {
    Get.lazyPut<WithdrawController>(() => WithdrawController(complete: () {}));
    Get.to(() => WithdrawView());
  }
}
