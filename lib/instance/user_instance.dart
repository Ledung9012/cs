import 'package:mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userInstance = UserInstance();

class UserInstance {
  static final UserInstance _singleton = UserInstance._internal();

  CSUser _user = CSUser(id: -1);

  String get password => _user.password;

  int get userId => _user.id;

  factory UserInstance() {
    return _singleton;
  }

  UserInstance._internal();

  Future<bool> alreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('USERID');
    return id != null;
  }

  bool isGuest() {
    alreadyLogin().then((value) {
      return value!;
    });
  }

  void login(CSUser user) async {
    _user = user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("USERID", user.id);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("USERID");
  }
}
