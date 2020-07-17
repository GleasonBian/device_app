/**
 * 保存账号密码
 * Create by Songlcy
 */
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class SavePwdModel extends Model {
  String _userid;
  String _password;
  bool _ispwd;

  get userid => _userid;
  get password => _password;
  get ispwd => _ispwd;

  void changeSavePwd({String userid,String password,bool ispwd}) async {
    _userid = userid;
    _password = password;
    _ispwd = ispwd;
    print('收到数据$userid,$password,$ispwd');
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("userid", userid);
    sp.setString("password", password);
    sp.setBool('ispwd', ispwd);
  }

  Future<Map> getSavePwd() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userid = sp.getString("userid");
    String password = sp.getString("password");
    bool ispwd = sp.getBool('ispwd');
    if (ispwd != null && ispwd) {
      return {
        userid:userid,
        password:password
      };
    }
    return {};
  }

  static SavePwdModel of(context) =>
      ScopedModel.of<SavePwdModel>(context, rebuildOnChange: true);
}
