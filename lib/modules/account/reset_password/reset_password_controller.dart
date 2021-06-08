import 'package:get/get.dart';

enum ResetPasswordState {
  none, // Trạng thái vừa mởi, Call api lấy mã xác thực
  autheCodeCorrect, //Trạng thái nhập mã xác nhận đúg
}

class ResetPasswordController extends GetxController {
  Rx<ResetPasswordState> resetPasswordstate = ResetPasswordState.none.obs;

  String phoneNumber = "0971568901";

  @override
  void onInit() {
    // TODO: implement onInit
  }

  bool isState(ResetPasswordState value) {
    return resetPasswordstate.value == value;
  }

  void submitAuthenCode(String value) {}

  void submit(String username, String password, String passwordConfirm,
      {required Function onSuccess,required Function(String) onFailure}) {
    // VALIDATE
    if (username.isEmpty) {
      onFailure("Vui lòng nhập số điện thoại");
      return;
    }

    if (password.isEmpty) {
      onFailure("Vui lòng nhập mật khẩu");
      return;
    }

    if (passwordConfirm.isEmpty) {
      onFailure("Vui lòng xác nhận mật khẩu");
      return;
    }

    if (password != password) {
      onFailure("Mật khẩu và xác nhận không giống nhau. Vui lòng kiểm tra lại");
      return;
    }

    // VALIDATE SUCCESS  -> CALL API
  }
}
