/**
 * 保存账号密码
 * Create by Songlcy
 */
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class SavePwdModel extends Model {
  String _userid;
  String _password;
  bool _ispwd = false;

  get userid => _userid;
  get password => _password;
  get ispwd => _ispwd;

  void changeSavePwd({String userid,String password}) async {
    _userid = userid;
    _password = password;
    print('账号/密码: $userid,$password');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("userid", userid);
    sp.setString("password", password);
    notifyListeners();
  }
  void changeIsPwd({bool ispwd}) async {
    _ispwd = ispwd;
    print('是否保存密码: $ispwd');
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('ispwd', ispwd);
  }
  void getSavePwd() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _userid = sp.getString("userid");
    _password = sp.getString("password");
    _ispwd = sp.getBool('ispwd');
    notifyListeners();
  }

  static SavePwdModel of(context) =>
      ScopedModel.of<SavePwdModel>(context, rebuildOnChange: true);
}
