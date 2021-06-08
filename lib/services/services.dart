import 'package:get/get.dart';
import 'package:mobile/services/api_response.dart';

enum APIFunction {


  APP_CONFIG,




  //--------------------USER
  USER_REGISTER,
  USER_LOGIN,
  USER_ALREADY_EXISTS,
  USER_INFO,
  USER_UPDATE_PASSWORD,

  //--------------------TRANSACTION
  TRANSACTION_SUMMARY,
  TRANSACTION_HISTORY,
  TRANSACTION_BANKS,
  TRANSACTION_WITHDRAW,

  //--------------------NEWS
  STORE_CATEGPRY,
  STORE_DETAIL,
  STORE_PRODUCTS,
  STORE_CATEGORY_MASTER,
  STORE_INDEX,
  STORE_ORDER_HISTORY,
  STORE_ORDER_CREATE,
  //--------------------NEWS
  NEWS_CATEGORY,
  NEWS_INDEX,
  NEWS_DETAIL,
  NEWS_CREATE,
  NEWS_UPDATE,
  NEWS_DELETE,
  NEWS_USER,

  //--------------------FILE
  FILE_UPLOAD
}

var apiRequest = ApiRequest();

class ApiRequest extends GetConnect {
  String url = "http://apicashback.lolshop.vn";

  static String path(APIFunction value) {
    switch (value) {
      case APIFunction.USER_UPDATE_PASSWORD:
        return "/user/update/password";
      case APIFunction.USER_REGISTER:
        return "/user/register";
      case APIFunction.USER_LOGIN:
        return "/user/login";
      case APIFunction.USER_ALREADY_EXISTS:
        return "/user/exists";
      case APIFunction.USER_INFO:
        return "/user/info";
      case APIFunction.APP_CONFIG:
        return "/app/config";

      //-------------------------------------------TRANSACTION
      case APIFunction.TRANSACTION_SUMMARY:
        return "/transaction/summary";
      case APIFunction.TRANSACTION_HISTORY:
        return "/transaction/history";
      case APIFunction.TRANSACTION_BANKS:
        return "/transaction/banks";
      case APIFunction.TRANSACTION_WITHDRAW:
        return "/transaction/withdraw";

      //-------------------------------------------STORE
      case APIFunction.STORE_CATEGPRY:
        return "/store/category";
      case APIFunction.STORE_DETAIL:
        return "/store/detail";
      case APIFunction.STORE_PRODUCTS:
        return "/store/product";
      case APIFunction.STORE_CATEGORY_MASTER:
        return "/store/category/master";
      case APIFunction.STORE_INDEX:
        return "/store/index";
      case APIFunction.STORE_ORDER_HISTORY:
        return "/store/order/history";
      case APIFunction.STORE_ORDER_CREATE:
        return "/store/order/create";

      //-------------------------------------------NEWS
      case APIFunction.NEWS_DETAIL:
        return "/news/detail";
      case APIFunction.NEWS_CATEGORY:
        return "/news/category";
      case APIFunction.NEWS_INDEX:
        return "/news/index";
      case APIFunction.NEWS_CREATE:
        return "/news/create";
      case APIFunction.NEWS_UPDATE:
        return "/news/update";
      case APIFunction.NEWS_DELETE:
        return "/news/delete";
      case APIFunction.NEWS_USER:
        return "/news/user";

      //-------------------------------------------FILE UPLOAD
      case APIFunction.FILE_UPLOAD:
        return "/upload";

    //-------------------------------------------Metadata
      case APIFunction.APP_CONFIG:
        return "/app/config";

    }
  }

  static final ApiRequest _singleton = ApiRequest._internal();

  factory ApiRequest() {
    return _singleton;
  }

  ApiRequest._internal();

  Future<ApiResponse> msRequest(APIFunction function, Map parameter) async {
    final response = await post(url + ApiRequest.path(function), parameter);
    if (response.status.hasError) {
      print("master request error : ${response.statusText}");
      return Future.error(response.statusText!);
    } else {
      print("API---------------------------------------------------- $function");
      print("Request-- $parameter");
      print("Response--  ${response.body}");

      ApiResponse apiResponse = ApiResponse.fromJson(response.body);
      return apiResponse;
    }
  }
}
