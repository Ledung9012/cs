import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/store.dart';
import 'package:mobile/modules/stores/store_detail/store_detail_controller.dart';
import 'package:mobile/modules/stores/store_detail/store_detail_view.dart';
import 'package:mobile/modules/stores/store_provider.dart';

class StoreController extends GetxController {
  final _provider = StoreProvider();
  RxList<Store> stores = List<Store>.empty().obs;

  int get categoryCount => categories.length;
  RxList<Category> categories = List<Category>.empty().obs;

  int get siteCount => stores.length;

  var _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectIndex(int value) {
    _selectedIndex = value;
    categories.refresh();
    index(categories[value].id);
  }

  @override
  // TODO: implement onStart
  get onStart => super.onStart;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    categoryMaster();
    index(selectedIndex);
  }

  void categoryMaster() {
    _provider.categoryMaster(
        success: (value) {
          categories.clear();
          categories.addAll(value);
          selectIndex(0);
        },
        onError: (value) {});
  }

  void index(int id) {
    stores.clear();
    _provider.index(id, onSuccess: (value) {
      stores.addAll(value);
      stores.refresh();
    }, onError: (error) {});
  }

  Category item(int value) {
    return this.categories[value];
  }

  Store store(int value) {
    return this.stores[value];
  }

  void detail(int index) {
    var item = this.stores[index];
    var detail = Get.put(StoreDetailController(item));
    detail.item = item;
    Get.to(StoreDetailView());
  }
}
