
import 'package:get/state_manager.dart';
import 'package:mobile/modules/home/home_controller.dart';
import 'package:mobile/services/services.dart';
import 'package:mobile/extension/map_extension.dart';
import 'package:get/get.dart';


var app = AppInstance();

class AppInstance {

  static final AppInstance _singleton = AppInstance._internal();
  factory AppInstance() {
    return _singleton;
  }

  AppInstance._internal();



  List items = [];


  var  enableInvestmentWallet = false;
  var  enableCashbackWallet = false;
  var  enableGiftMission = false;
  var  enableShopping = false;
  var  enableCashbackProduct = false;
  var  accessTradeURL = false;
  var  enableCashbackStore = false;




  void loadConfig(){
    apiRequest.msRequest(APIFunction.APP_CONFIG, Map()).then((response) {
      items = response.data ;
      updateConfig() ;


    }).onError((error, stackTrace) {


      print("Update config error $error");
    });
  }

  void updateConfig(){

    enableInvestmentWallet = getMap("enableInvestmentWallet").boolValue("value");
    enableCashbackWallet = getMap("enableCashbackWallet").boolValue("value");
    enableGiftMission = getMap("enableGiftMission").boolValue("value");

    // Dùng cho tab mua hàng và trang Lịch sử mua hàng
    enableShopping = getMap("enableShopping").boolValue("value");

    enableCashbackProduct = getMap("enableCashbackProduct").boolValue("value");

    accessTradeURL = getMap("accessTradeURL").boolValue("value");

    // Dùng cho tab thương hiệu và ví hoàn tiền mua sắm
    enableCashbackStore = getMap("enableCashbackStore").boolValue("value");



    var homeController = Get.put(HomeController());
    homeController.loadConfigComplete = true ;

  }

  Map getMap(String key)
  {
    if(items.firstWhere((currency) => currency["key"] == key) != null){
      return items.firstWhere((currency) => currency["key"] == key);
    }
    return Map();
  }
}
