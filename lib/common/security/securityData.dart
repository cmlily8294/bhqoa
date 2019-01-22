
import 'package:bhqoa/common/http/api.dart';
import 'package:bhqoa/common/http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityData {
  /// 获取用户信息
  Future<dynamic> getUserInfo() async {
    return await Http().post(API.getUserInfo);
  }
  /// 登录
  Future<dynamic> loginAjax(String userName, String password) async {
    return await Http().post('${API.tickets}?username=$userName&password=$password');
  }
  /// 验证tickets
  Future<dynamic> ticketsValidateAjax(String tgt) async {
    return await Http().post('${API.ticketsValidate}/$tgt');
  }
  /// 创建ST
  Future<dynamic> serviceTicketsAjax(String tgt, String service) async {
    return await Http().post('${API.serviceTickets}/$tgt?service=$service');
  }
  /// 删除TGT
  Future<dynamic> deleteTicketsAjax(String tgt) async {
    return await Http().delete('${API.tickets}/$tgt');
  }
  /// 模拟登录，解决服务端登录问题
  Future<dynamic> mklogin(String ticket) async {
    return await Http().get('${API.mklogin}?ticket=$ticket');
  }
  /// 模拟登录，解决服务端登录问题
  Future<dynamic> loginOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    return await Http().get('${API.logout}?ticket=$jwt');
  }
  /// 用户注册信息
  Future<dynamic> userRegister(String ac, String pw, String rpw) async {
    return await Http().post('${API.userRegister}/$ac/$pw/$rpw');
  }
  /// 设置密码
  Future<dynamic> setPassword(String op, String np) async {
    return await Http().post('${API.setPassword}/$op/$np');
  }
}