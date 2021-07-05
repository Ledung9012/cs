import 'package:get/get.dart';
import 'package:mobile/extension/string_extension.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/transaction.dart';
import 'package:mobile/modules/transaction/transaction_provider.dart';

class TransactionController extends GetxController {
  var _provider = TransactionProvider();

  var transactionSummary = TransactionSummary().obs;

  String get available => transactionSummary.value.available.currencyValue();

  String get withdraw => transactionSummary.value.withdraw.currencyValue();

  String get cashback => transactionSummary.value.cashback.currencyValue();

  RxList<Transaction> transactions = List<Transaction>.empty().obs;

  void history() {
    _provider.history(
        userId: userInstance.userId,
        onSuccess: (value) {
          transactions.addAll(value);
          transactions.refresh();
        },
        onError: (value) {});
  }

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
    history();
    summary();
  }
}
