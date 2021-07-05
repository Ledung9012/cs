import 'package:mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userInstance = UserInstance();

class UserInstance {
  static final UserInstance _singleton = UserInstance._internal();

  CSUser _user = CSUser(id: -1);

  String get password => _user.password;

  int get userId => _user.id;

  var logged = false;

  var acceptLigal = false;

  factory UserInstance() {
    return _singleton;
  }

  UserInstance._internal();

  Future<bool> alreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('USERID');
    logged = (id != null);
    if (logged) {
      _user.id = id!;
    }
    return logged;
  }

  Future<bool> login(int userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("USERID", userID);
    _user.id = userID;
    return true;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("USERID");
  }
}
