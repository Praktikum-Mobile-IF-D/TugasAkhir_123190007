import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setLogin(String username, String password) async {
    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', true);
    getPref.setString('username', username);
    getPref.setString('password', password);
  }

  void setLogout() async {
    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', false);
    getPref.remove('username');
  }

  void setImage(String image) async {
    SharedPreferences getPref = await _pref;
    getPref.setString('images', image);
  }

  static Future<String> getImage() async {
    SharedPreferences getPref = await _pref;
    String image = getPref.getString('images') ?? "";
    return image;
  }

  static Future<String> getPassword() async {
    SharedPreferences getPref = await _pref;
    String password = getPref.getString('password') ?? "";
    return password;
  }

  static Future<String> getUsername() async {
    SharedPreferences getPref = await _pref;
    String username = getPref.getString('username') ?? 'notFound';
    return username;
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences getPref = await _pref;
    bool loginStatus = getPref.getBool('isLogin') ?? false;
    return loginStatus;
  }


}