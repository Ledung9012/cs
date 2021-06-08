import 'package:get/get.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/services.dart';

class AccountProvider extends GetConnect {
  void userInfo(
      {required int id,
        required Function(CSUser) success,
        required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.USER_INFO, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(CSUser.fromJson(response.data));
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void changePassword(
      {required int id,
        required String password,
        required String newPassword,
        required Function() success,
        required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;
    body['password'] = password;
    body['newPassword'] = newPassword;
    apiRequest
        .msRequest(APIFunction.USER_UPDATE_PASSWORD, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.message);
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void register(String phone, String password, Function(CSUser) success,
      Function(String) onError) {
    Map body = Map();
    body['username'] = phone;
    body['password'] = password;

    apiRequest.msRequest(APIFunction.USER_REGISTER, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(CSUser.fromJson(response.data));
      }
    }).onError((error, stackTrace) {
      print("on error : $error");
      onError(error.toString());
    });
  }
}
