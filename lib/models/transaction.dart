import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/extension/map_extension.dart';
import 'package:mobile/extension/string_extension.dart';

enum TransactionType {
  CASHBACK,
  WITHDRAW,
  NONE,
}

enum TransactionStatus {
  PROCESS,
  SUCCESS,
  REJECT,
  NONE,
}

class WithdrawRequest {
  var userId = -1;
  var bankId = "";
  var name = "";
  var number = "";
  var value = 0.0;
}

class TransactionSummary {
  double cashback = 0.0;
  double withdraw = 0.0;
  double available = 0.0;
  double withdraw_process = 0.0;
  double cashback_process = 0.0;

  TransactionSummary();

  TransactionSummary.fromJson(Map<String, dynamic> json) {
    cashback = json.doubleValue("cashback");
    withdraw = json.doubleValue("withdraw");
    available = json.doubleValue("available");
    withdraw_process = json.doubleValue("withdraw_process");
    cashback_process = json.doubleValue("cashback_process");

  }
}

class Transaction {
  static List<Transaction> list(List json) {
    return json.map((entry) => Transaction.fromJson(entry)).toList();
  }

  int id = 0;
  double commission = 0.0;
  int userId = -1;
  TransactionStatus status = TransactionStatus.NONE;
  TransactionType transactionType = TransactionType.NONE;
  String model = "";
  String createdAt = "";
  String targetName = "";

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json.intValue("id");
    transactionType = json.stringValue("type").toEnum(TransactionType.values);
    status = json.stringValue("status").toEnum(TransactionStatus.values);
    userId = json.intValue("userId");
    commission = json.doubleValue("commission");
    createdAt = json.stringValue("created_at");
    targetName = json.stringValue("target_name");
  }

  String get valueDisplay => commission.currencyValue();

  String dateDisplay() {
    if (DateTime.tryParse(createdAt) != null) {
      var date = DateTime.parse(createdAt).stringValue();
      print("date : $date");
      return date;
    }
    return "";
  }

  Widget statusIcon(double size) {
    if (status == TransactionStatus.PROCESS)
      return Icon(
        Icons.pending_rounded,
        size: size,
        color: statusColor(),
      );
    if (status == TransactionStatus.REJECT)
      return Icon(
        Icons.cancel_rounded,
        size: size,
        color: statusColor(),
      );
    if (status == TransactionStatus.SUCCESS)
      return Icon(
        Icons.check_circle,
        size: size,
        color: statusColor(),
      );
    if (status == TransactionStatus.NONE)
      return Icon(
        Icons.check_circle,
        size: size,
        color: statusColor(),
      );

    return Container();
  }

  bool isaccesstrade() {
    return (transactionType == TransactionType.CASHBACK);
  }

  bool isWithdraw() {
    return !isaccesstrade();
  }

  String label() {
    if (transactionType == TransactionType.CASHBACK)
      return "C???a h??ng " + targetName;
    if (transactionType == TransactionType.WITHDRAW)
      return "Ng??n h??ng " + targetName;
    return "N/A";
  }

  Color labelColor() {
    switch (transactionType) {
      case TransactionType.CASHBACK:
        return Colors.green;
      case TransactionType.WITHDRAW:
        return Colors.redAccent;
      case TransactionType.NONE:
        return Colors.green;
    }
  }

  Color backgroundColor() {
    switch (status) {
      case TransactionStatus.SUCCESS:
        return Colors.green[50]!;
      case TransactionStatus.REJECT:
        return Colors.redAccent[50]!;
      case TransactionStatus.PROCESS:
        return Colors.orange[50]!;
      case TransactionStatus.NONE:
        return Colors.green[50]!;
    }
  }

  Color statusColor() {
    switch (status) {
      case TransactionStatus.SUCCESS:
        return Colors.green;
      case TransactionStatus.REJECT:
        return Colors.red;
      case TransactionStatus.PROCESS:
        return Colors.orange;
      case TransactionStatus.NONE:
        return Colors.red;
    }
  }

  String statusLabel() {
    switch (status) {
      case TransactionStatus.SUCCESS:
        return "Ho??n t???t";
      case TransactionStatus.REJECT:
        return "Kh??ng th??nh c??ng";
      case TransactionStatus.PROCESS:
        return "??ang x??? l??";
      case TransactionStatus.NONE:
        return "";
    }
  }

  String typeLabel() {
    switch (transactionType) {
      case TransactionType.CASHBACK:
        return "Ho??n ti???n";
      case TransactionType.WITHDRAW:
        return "R??t ti???n";
      case TransactionType.NONE:
        return "";
    }
  }
}
