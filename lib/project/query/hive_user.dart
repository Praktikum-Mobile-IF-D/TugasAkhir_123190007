import 'package:hive/hive.dart';
import '../model/hive_model.dart';

class HiveUser{
  final Box _localDB = Hive.box("akun");

  void addData(UserAccountModel data) {
    _localDB.add(data);
  }


  int getLength() {
    return _localDB.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for(int i = 0; i< getLength(); i++){
      if (username == _localDB.getAt(i)!.username && password == _localDB.getAt(i)!.password) {
        found = true;
        break;
      } else {
        found = false;
      }
    }
    return found;
  }

  bool checkUsers(String username) {
    bool found = false;
    for(int i = 0; i< getLength(); i++){
      if (username == _localDB.getAt(i)!.username) {
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }

}