import 'package:get/get.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/faq.dart';
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

  void updateImage(
      {required int id,
      required String image,
      required Function() success,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;
    body['image'] = image;

    print("---------${APIFunction.USER_UPDATE_IMAGE}");
    apiRequest.msRequest(APIFunction.USER_UPDATE_IMAGE, body).then((response) {
      if (response.hasError()) {
        onError(response.message);
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void register(String phone, String password, String name,
      Function(int) success, Function(String) onError) {
    Map body = Map();
    body['username'] = phone;
    body['password'] = password;
    body['name'] = name;

    apiRequest.msRequest(APIFunction.USER_REGISTER, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(response.data);
      }
    }).onError((error, stackTrace) {
      print("on error : $error");
      onError(error.toString());
    });
  }

  void login(String phone, String password, Function(CSUser) success,
      Function(String) onError) {
    Map body = Map();
    body['username'] = phone;
    body['password'] = password;

    apiRequest.msRequest(APIFunction.USER_LOGIN, body).then((response) {
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

  void support(
      {required Function(List<CSUser>) success,
      required Function(String) onError}) {
    Map body = Map();
    apiRequest.msRequest(APIFunction.USER_SUPPORT, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(CSUser.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void faq(
      {required Function(List<Faq>) success,
      required Function(String) onError}) {
    Map body = Map();
    apiRequest.msRequest(APIFunction.USER_FAQ, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(Faq.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void userCheckAlreadyExists(String phone, String password,
      Function(bool) success, Function(String) onError) {
    Map body = Map();
    body['username'] = phone;
    body['password'] = password;

    apiRequest
        .msRequest(APIFunction.USER_ALREADY_EXISTS, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        Map result = response.data;

        if (result['value'] == 1) {
          success(true);
        } else {
          success(false);
        }
      }
    }).onError((error, stackTrace) {
      print("on error : $error");
      onError(error.toString());
    });
  }

  void resetPassword(String phone, String password, Function() success,
      Function(String) onError) {
    Map body = Map();
    body['username'] = phone;
    body['password'] = password;

    apiRequest
        .msRequest(APIFunction.USER_RESET_PASSWORD, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  void updateToken(
      String token, Function() success, Function(String) onError) {
    Map body = Map();
    body['token'] = token;
    body['id'] = userInstance.userId;

    apiRequest
        .msRequest(APIFunction.NOTIFICATION_UPDATE_TOKEN, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      print("on error : $error");
      onError(error.toString());
    });
  }
}
