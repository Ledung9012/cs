

import 'package:get/get.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/transaction.dart';
import 'package:mobile/modules/transaction/transaction_provider.dart';

class TransactionHistoryController extends GetxController{

  var _provider = TransactionProvider();

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
  void onInit() {
    history();
    super.onInit();
  }


  Transaction item(int index){
    return transactions[index] ;
  }
}