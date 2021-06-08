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
  PROCESSING,
  SUCCESS,
  REJECT,
  NONE,
}


class WithdrawRequest {
  var userId = -1 ;
  var bankId = "" ;
  var name = "" ;
  var number = "" ;
  var value = 0.0 ;
}

class TransactionSummary {
  double cashback = 0.0;
  double withdraw = 0.0;
  double available = 0.0;

  TransactionSummary();

  TransactionSummary.fromJson(Map<String, dynamic> json) {
    cashback = json.doubleValue("cashback");
    withdraw = json.doubleValue("withdraw");
    available = json.doubleValue("available");
  }

}

class Transaction {
  static List<Transaction> list(List json) {
    return json.map((entry) => Transaction.fromJson(entry)).toList();
  }

  int id = 0;
  double value = 0.0;
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
    value = json.doubleValue("value");
    createdAt = json.stringValue("created_at");
    targetName = json.stringValue("target_name");

  }

  String get valueDisplay => value.currencyValue();

  String dateDisplay(){
    if(DateTime.tryParse(createdAt) != null){
      var date = DateTime.parse(createdAt).stringValue();
      print("date : $date");
      return date;
    }
    return "" ;
  }


  Widget statusIcon(double size) {
    if (status == TransactionStatus.PROCESSING)
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
    if (transactionType == TransactionType.CASHBACK) return "Cửa hàng " + targetName;
    if (transactionType == TransactionType.WITHDRAW) return "Ngân hàng " + targetName;
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
      case TransactionStatus.PROCESSING:
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
      case TransactionStatus.PROCESSING:
        return Colors.orange;
      case TransactionStatus.NONE:
        return Colors.red;
    }
  }

  String statusLabel() {
    switch (status) {
      case TransactionStatus.SUCCESS:
        return "Hoàn tất";
      case TransactionStatus.REJECT:
        return "Không thành công";
      case TransactionStatus.PROCESSING:
        return "Đang xử lý";
      case TransactionStatus.NONE:
        return "";
    }
  }


  String typeLabel() {
    switch (transactionType) {
      case TransactionType.CASHBACK:
        return "Hoàn tiền";
      case TransactionType.WITHDRAW:
        return "Rút tiền";
      case TransactionType.NONE:
        return "";
    }
  }

}
