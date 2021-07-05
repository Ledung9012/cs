import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/models/store.dart';
import 'package:mobile/services/services.dart';

class StoreProvider extends GetConnect {
  void category(
      {required Function(List<Category>) onSuccess,
      required Function(String) onError}) {
    Map body = Map();
    apiRequest.msRequest(APIFunction.STORE_CATEGORY, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(Category.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }

  void index(int id,
      {required Function(List<Store>) onSuccess,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;
    apiRequest.msRequest(APIFunction.STORE_INDEX, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(Store.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }

  void products(int id,
      {required Function(List<Product>) onSuccess,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = id;

    apiRequest.msRequest(APIFunction.STORE_PRODUCTS, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        onSuccess(Product.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }

  void categoryMaster(
      {required Function(List<Category>) success,
      required Function(String) onError}) {
    Map body = Map();
    apiRequest
        .msRequest(APIFunction.STORE_CATEGORY_MASTER, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(Category.list(response.data));


      }
    }).onError((error, stackTrace) {
      onError("error");
    });
  }

  static void orderHistory(
      {required int userId,
      required Function(List<Order>) success,
      required Function(String) onError}) {
    Map body = Map();
    body['id'] = userId;
    apiRequest
        .msRequest(APIFunction.STORE_ORDER_HISTORY, body)
        .then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success(Order.list(response.data));
      }
    }).onError((error, stackTrace) {
      onError("");
    });
  }

  static void orderCreate(
      {required OrderCreateRequest request,
      required Function() success,
      required Function(String) onError}) {



    print("Order create ");

    Map body = Map();
    body['userId'] = request.userId;
    body['name'] = request.name;
    body['address'] = request.address;
    body['phone'] = request.phone;
    body['products'] = request.products;

    apiRequest.msRequest(APIFunction.STORE_ORDER_CREATE, body).then((response) {
      if (response.hasError()) {
        onError(response.errorDisplay());
      } else {
        success();
      }
    }).onError((error, stackTrace) {

      print(error);
      onError("");
    });
  }
}
