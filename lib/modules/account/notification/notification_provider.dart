import 'package:get/get.dart';
import 'package:mobile/models/notification.dart';
import 'package:mobile/services/services.dart';

class NotificationProvider extends GetConnect {
  void user(
      {required int id,
        required Function(List<SNotification>) success,
        required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.NOTIFICATION_USER, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(SNotification.list(response.data));
      }
    }).onError((error, stackTrace) {

      print("error ---------${error}");
      onError(error.toString());
    });
  }


}


