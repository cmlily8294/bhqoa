import 'dart:convert';
import 'dart:io';
import 'package:bhqoa/common/http/api.dart';
import 'package:bhqoa/common/http/http.dart';
import 'package:bhqoa/common/security/securityData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityService {
  SecurityData securityData = SecurityData();

  var user;

  // 工厂模式 创建单例
  factory SecurityService() => _getInstance();

  static SecurityService get instance => _getInstance();
  static SecurityService _instance;

  static SecurityService _getInstance() {
    if (_instance == null) {
      _instance = new SecurityService._init();
    }
    return _instance;
  }

  SecurityService._init() {

  }

  Future<dynamic> getUserInfo() async {
    dynamic userInfo = await securityData.getUserInfo();
    if (userInfo != null && userInfo['user'] != null) {
      user = userInfo['user'];
    } else {
      user = null;
    }
    return userInfo;
  }

  Future<dynamic> login(String userName, String password) async {
    dynamic td = await securityData.loginAjax(userName, password);
    if (td == null) {
      // TODO 登录错误处理
      return false;
    } else {
      String tgt = td['ok'];
      Http().dio.cookieJar.saveFromResponse(Uri.parse(API.baseUrl), [new Cookie("SSO_TGT",tgt)]);
      return await this._innerLogin(tgt);
    }
  }

  Future<dynamic> _innerLogin(String tgt) async{
    dynamic sd = await securityData.serviceTicketsAjax(tgt, Uri.encodeComponent(API.ssoService));
    if (sd == null) {
      print('登录失败');
      // TODO 登录错误处理
      return false;
    } else {
      String ticket = sd['ok'];
      dynamic jsd = await securityData.mklogin(ticket);
      if (jsd != null && jsd !='') {
        // Http().dio.cookieJar.saveFromResponse(Uri.parse(API.baseUrl), [new Cookie("jwt",jsd.jwt)]);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map decodeJsd = json.decode(jsd);
        prefs.setString('jwt', decodeJsd['jwt']);
        return await this.getUserInfo();
      } else {
        // TODO 登录错误处理
        return false;
      }
    }

  }



}