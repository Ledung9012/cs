import 'package:get/get.dart';
import 'package:mobile/models/promotion.dart';
import 'package:mobile/models/store.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class PromotionController extends GetxController {
  StoreProvider _storeProvider = StoreProvider();

  int get promotionLength => promotions.length;
  RxList<Promotion> promotions = List<Promotion>.empty().obs;

  int get storeLength => stores.length;
  RxList<Store> stores = List<Store>.empty().obs;

  @override
  void onInit() {
    // TODO: implement onInit

    stores.add(Store(-1, "Tất Cả", ""));

    loadPromotion();
    super.onInit();
  }

  void loadPromotion() {

    promotions.clear();

    _storeProvider.promotion(
        id: -1,
        success: (value) {
          promotions.addAll(value);
          // stores.addAll(promotions.map((element) => element.store()).toList()) ;
          promotions.refresh();
        },
        onError: (value) {

        });
  }


  var _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectIndex(int value) {
    _selectedIndex = value;
    stores.refresh();
  }

  Store item(int index){
    return stores.value[index];
  }
}
