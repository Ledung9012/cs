import 'package:mobile/models/bank.dart';
import 'package:mobile/models/transaction.dart';
import 'package:mobile/services/services.dart';

class TransactionProvider {
  void summary(
      {required int userId,
      required Function(TransactionSummary) onSuccess,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = userId;

    apiRequest
        .msRequest(APIFunction.TRANSACTION_SUMMARY, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        var summary = TransactionSummary.fromJson(response.data);
        onSuccess(summary);
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }

  void banks(
      {required Function(List<Bank>) onSuccess,
      required Function(String) onError}) {
    Map body = Map();
    apiRequest
        .msRequest(APIFunction.TRANSACTION_BANKS, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(Bank.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }

  void withdraw({required WithdrawRequest request ,required Function() onSuccess,
        required Function(String) onError}) {
    Map body = Map();
    body['userId'] = request.userId;
    body['bankId'] = request.bankId;
    body['name'] = request.name;
    body['number'] = request.number;
    body['value'] = request.value;

    apiRequest
        .msRequest(APIFunction.TRANSACTION_WITHDRAW, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess();
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }


  void history(
      {required int userId,
      required Function(List<Transaction>) onSuccess,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = userId;

    apiRequest
        .msRequest(APIFunction.TRANSACTION_HISTORY, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(Transaction.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }
}
