import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/bank.dart';
import 'package:mobile/models/transaction.dart';
import 'package:mobile/modules/transaction/transaction_provider.dart';

class WithdrawController extends GetxController {
  final textInputOwnerController = TextEditingController();
  final textInputNumberController = TextEditingController();
  final cashInputOwnerController = TextEditingController();
  var transactionSummary = TransactionSummary().obs;

  RxList<Bank> banks = List<Bank>.empty().obs;
  var _provider = TransactionProvider();
  var bankId;
  Function complete ;
  WithdrawController({required this.complete});

  @override
  void onInit() {
    super.onInit();
    getBank();
    summary();
  }

  void getBank() {
    banks.clear();
    _provider.banks(
        onSuccess: (value) {
          banks.addAll(value);
        },
        onError: (error) {});
  }

  void accept(Function onSuccess, Function(String) onError) {
    // Validate

    var error;

    if (bankId == null) {
      error = "Vui lòng chọn ngân hàng";
      onError(error);
      return;
    }

    String name = textInputOwnerController.text;
    if (name.isEmpty) {
      error = "Vui lòng nhập tên chủ tài khoản";
      onError(error);
      return;
    }

    String number = textInputNumberController.text;
    if (number.isEmpty) {
      error = "Vui lòng nhập số tài khoản";
      onError(error);
      return;
    }

    if (cashInputOwnerController.text.isEmpty) {
      error = "Vui lòng nhập số tiền ";
      onError(error);
      return;
    }

    var cash = double.parse(cashInputOwnerController.text);
    if (cash <= 0) {
      error = "Số tiền chuyển không hợp lệ";
      onError(error);
      return;
    }

    if (cash < 10000) {
      error = "Số tiền chuyển tối thiểu là 10.000 đồng";
      onError(error);
      return;
    }

    if (cash > transactionSummary.value.available) {
      error = "Số tiền chuyển không được lớn hơn số dư khả dụng";
      onError(error);
      return;
    }

    WithdrawRequest request = WithdrawRequest();
    request.value = cash;
    request.userId = 2;
    request.number = number;
    request.name = name;
    request.bankId = bankId.toString();

    _provider.withdraw(
        request: request,
        onSuccess: () {
          onSuccess();
          clear();
        },
        onError: (error) {
          onError(error);
        });
  }

  void clear(){
    textInputOwnerController.text = "";
    textInputNumberController.text = "";
    cashInputOwnerController.text = "";
    textInputOwnerController.text = "";
    summary();
  }


  void summary() {
    _provider.summary(
        userId: 2,
        onSuccess: (value) {
          transactionSummary.value = value;
        },
        onError: (value) {});
  }
}
