import 'package:get/get.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/notification.dart';
import 'package:mobile/modules/account/notification/notification_provider.dart';
import 'package:mobile/modules/news/create/news_create_controller.dart';
import 'package:mobile/modules/news/create/news_create_view.dart';

class NotificationController extends GetxController {
  RxList<SNotification> _notification = List<SNotification>.empty().obs;

  int get newsLength => _notification.length;

  NotificationProvider _provider = NotificationProvider();

  @override
  void onInit() {
    loadNews();
  }

  void loadNews() {
    _notification.clear();

    _provider.user(id: userInstance.userId,
        success: (data) {
          _notification.addAll(data);
          
          print("count : ${_notification.length}");
          _notification.refresh();
        },
        onError: (error) {});
  }

  void create() {
    Get.lazyPut<NewsCreateController>(() => NewsCreateController());
    Get.to(() => NewsCreateView());
  }

  SNotification item(int index) {
    return _notification[index];
  }
}
