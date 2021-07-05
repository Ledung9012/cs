import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/modules/account/login/login_controller.dart';
import 'package:mobile/modules/account/login/login_view.dart';
import 'package:mobile/modules/news/create/news_create_controller.dart';
import 'package:mobile/modules/news/create/news_create_view.dart';
import 'package:mobile/modules/news/news_provider.dart';

class NewsController extends GetxController {
  RxList<Category> categories = List<Category>.empty().obs;
  var favor = false.obs;
  int get categoryLength => categories.value.length;
  Category categoryIndex(int index) => categories[index];

  int initalTabbarIndex(){
    print("inital ---");
    if(favor.value){
      return categories.length -1 ;
    }
    return 0 ;
  }
  void favorToggle() {
    favor.value = !favor.value;
    categories.clear();

  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  void onInit() {
    super.onInit();
    getCategory();
  }

  void loadMore(String value) {}

  void onChange(String value) {}

  void getCategory() {
    NewsProvider().category(
        onSuccess: (value) {
          categories.clear();
          categories.add(Category(-1, "Tất Cả"));
          categories.addAll(value);
          categories.add(Category(-2, "Danh sách yêu thích"));
        },
        onError: (value) {});
  }

  void create() {
    Get.lazyPut<NewsCreateController>(() => NewsCreateController());
    Get.to(() => NewsCreateView());
  }

  void logon() {
    Get.put(LoginController(authenSuccess: () {}, authenFalse: (val) {}));
    Get.to(LoginView());
  }
}
