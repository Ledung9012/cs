import 'package:get/get.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/news.dart';
import 'package:mobile/modules/news/detail/news_detail_controller.dart';
import 'package:mobile/modules/news/detail/news_detail_view.dart';
import 'package:mobile/modules/news/news_provider.dart';

class NewsController extends GetxController {
  NewsProvider _provider = NewsProvider();
  RxList<News> _news = List<News>.empty().obs;
  RxList<Category> _categories = List<Category>.empty().obs;
  var newsCount = 0.obs;

  var _categorySelected = 0.obs;

  int get categoryLength => _categories.value.length;

  int get newsLength => _news.length;

  int get categorySelected => _categorySelected.value;

  Category categoryIndex(int index) => _categories[index];

  News newsIndex(int index) => _news[index];

  void selectCategory(int index) {
    int reIndex = index;
    if (reIndex == categoryLength) {
      reIndex = 0;
    }

    if (reIndex < 0) {
      reIndex = categoryLength - 1;
    }
    _categorySelected.value = reIndex;
    _categories.refresh();
    getNewst();
  }

  void next() {
    selectCategory(_categorySelected.value + 1);
  }

  void refresh() {
    newsCount.value = _news.length;
    _news.refresh();
  }

  void previous() {
    selectCategory(_categorySelected.value - 1);
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
    print("Category new--------");
    _provider.category(
        onSuccess: (value) {
          _categories.clear();
          _categories.add(Category(-1, "Tất Cả"));
          _categories.addAll(value);
          getNewst();
        },
        onError: (value) {});
  }

  void getNewst() {
    _news.clear();

    // _provider.index(_categories[categorySelected].id,onSuccess: (value) {
    //   _news.addAll(value);
    //   _news.refresh();
    // });

    _provider.index(_categories[categorySelected].id, (value) {
      _news.addAll(value);
      _news.refresh();
      print("Page ---- : ${_news.length}");
    }, (error) {});
  }

  void goCreate(int index) {
    // var detailController = Get.put(NewsCreateController());
    // detailController.clear();
    // Get.to(NewsCreateView());
  }

  void goDetail(int index) {
    var detailController = Get.put(NewsDetailController());
    detailController.list.clear();
    detailController.list.addAll(_news[index].nodes);
    Get.to(NewsDetailView());
  }
}
