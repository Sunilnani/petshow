import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseNetwork {
  factory BaseNetwork() {
    return _singleton;
  }
  BaseNetwork._internal() {
    _init();
  }

  static final BaseNetwork _singleton = BaseNetwork._internal();

  Future<String> _getAuthorizationToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token") ?? '';

  }

  Dio _dio;
  dynamic _init() {
    // Token Dio with no Heade

    _dio = Dio();
    _dio.options = BaseOptions(
      baseUrl: "https://api.npoint.io/5251edda932f79c3728b",
      validateStatus: (status) => status < 500,
    );


  }

  Dio get ref => _dio;
}

final dioClient = BaseNetwork();
