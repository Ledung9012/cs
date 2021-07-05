import 'package:get/get.dart';
import 'package:mobile/modules/center/contact/support_controller.dart';

class HelpCenterController extends GetxController with StateMixin {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    
    print("================HELP CENTER============================");

    Get.put(SupportController());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
