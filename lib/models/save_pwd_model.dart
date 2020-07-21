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

  /**
   * @date: 2020/7/21 10:04
   * @author: Gleason
   * @content: 保存密码
   */
  void changeSavePwd({String userid,String password}) async {
    _userid = userid;
    _password = password;
    print('账号/密码: $userid,$password');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("userid", userid);
    sp.setString("password", password);
    notifyListeners();
  }

  /**
   * @date: 2020/7/21 10:04
   * @author: Gleason
   * @content: 是否保存密码
   */
  void changeIsPwd({bool ispwd}) async {
    _ispwd = ispwd;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('ispwd', ispwd);
  }

  /**
   * @date: 2020/7/21 10:03
   * @author: Gleason
   * @content: 删除保存的账号密码
   */
  void remove()  async{
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('userid');
    sp.remove('password');
  }

  /**
   * @date: 2020/7/21 10:04
   * @author: Gleason
   * @content: 获取保存的账号密码
   */
  void getSavePwd() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString("userid") == null ? _userid = "" : _userid = sp.getString("userid");
    sp.getString("password") == null ? _password = '' :  _password = sp.getString("password");
    sp.getBool('ispwd') ==null ? _ispwd = false: _ispwd = sp.getBool('ispwd') ;
    notifyListeners();
  }

  /**
   * @date: 2020/7/21 10:05
   * @author: Gleason
   * @content: 简化操作
   */
  static SavePwdModel of(context) =>
      ScopedModel.of<SavePwdModel>(context, rebuildOnChange: true);
}
