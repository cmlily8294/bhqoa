import 'package:bhqoa/common/http/api.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Http {
  Dio dio;
  Options options;

  // 工厂模式 创建单例
  factory Http() => _getInstance();

  static Http get instance => _getInstance();
  static Http _instance;

  static Http _getInstance() {
    if (_instance == null) {
      _instance = new Http._init();
    }
    return _instance;
  }


  Http._init() {
    Map headers = Map<String, dynamic>();
    headers['Origin'] = 'http://localhost:8100'; // todo 端上的接口不应该有这个跨域限制
    options = Options(
      baseUrl: API.baseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: headers,
    );
    dio = new Dio(options);
    dio.interceptor.request.onSend = (Options opts) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jwt = prefs.getString('jwt');
      if (jwt != null && jwt.isNotEmpty) {
        opts.headers['jwt'] = jwt;
      }
      return opts;
    };
  }

  get(url, {data, options, cancelToken}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return response.data??null;
  }

  post(url, {data, options, cancelToken}) async {
    print('post请求启动! url：$url ,data: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response.data??null;
  }

  delete(url, {data, options, cancelToken}) async {
    print('delete启动! url：$url ,data: $data');
    Response response;
    try {
      response = await dio.delete(
        url,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      print('delete成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('delete取消! ' + e.message);
      }
      print('delete发生错误：$e');
    }
    return response.data??null;
  }

}