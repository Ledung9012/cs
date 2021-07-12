import 'package:get/get.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/services/services.dart';

class AddressProvider extends GetConnect {
  static void item(
      {required int id,
      required APIFunction func,
      required Function(List<AddressItem>) success,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(func, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(AddressItem.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  static void add(
      {required Address request,
      required Function() success,
      required Function(String) onError}) {
    Map body = Map();

    body['user_id'] = request.userId;
    body['province_id'] = request.provinceId;
    body['district_id'] = request.districtId;
    body['ward_id'] = request.wardId;
    body['description'] = request.description;
    body['name'] = request.name;
    body['phone'] = request.phone;

    apiRequest.msRequest(APIFunction.ADDRESS_CREATE, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  static void update(
      {required Address request,
      required Function() success,
      required Function(String) onError}) {
    Map body = Map();

    body['id'] = request.id;
    body['user_id'] = request.userId;
    body['province_id'] = request.provinceId;
    body['district_id'] = request.districtId;
    body['ward_id'] = request.wardId;
    body['description'] = request.description;
    body['name'] = request.name;
    body['phone'] = request.phone;

    apiRequest.msRequest(APIFunction.ADDRESS_UPDATE, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }

  static void user(
      {required Function(List<Address>) success,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = userInstance.userId;

    apiRequest.msRequest(APIFunction.ADDRESS_USER, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(Address.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }


  static void deleteItem( {required int id, required Function() success,
        required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.ADDRESS_DELETE, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success();
      }
    }).onError((error, stackTrace) {
      onError(error.toString());
    });
  }
}
