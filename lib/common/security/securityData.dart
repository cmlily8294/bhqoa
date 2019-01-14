
import 'package:bhqoa/common/http/api.dart';
import 'package:bhqoa/common/http/http.dart';

class SecurityData {
  Future<dynamic> getUserInfo() async {
    var userInfo = await Http().post(API.getUserInfo);
    return userInfo;
  }
}