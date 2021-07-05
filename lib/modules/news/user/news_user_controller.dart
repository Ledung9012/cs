import 'package:get/get.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/news.dart';
import 'package:mobile/modules/account/login/login_controller.dart';
import 'package:mobile/modules/account/login/login_view.dart';
import 'package:mobile/modules/news/create/news_create_controller.dart';
import 'package:mobile/modules/news/create/news_create_view.dart';
import 'package:mobile/modules/news/news_provider.dart';

class NewsUserController extends GetxController {
  RxList<News> _news = List<News>.empty().obs;

  int get newsLength => _news.length;

  NewsProvider _newsProvider = NewsProvider();

  @override
  void onInit() {
    loadNews();
  }

  void loadNews() {
    _news.clear();
    _newsProvider.user(userInstance.userId, (p0) {
      _news.addAll(p0);
      _news.refresh();
    }, (p0) {});
  }

  void create() {
    Get.lazyPut<NewsCreateController>(() => NewsCreateController());
    Get.to(() => NewsCreateView());
  }



  News item(int index) {
    return _news[index];
  }
}
