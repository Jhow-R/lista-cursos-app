import 'package:dio/dio.dart';

// Classe de configuração e os interceptadores
class ServiceConfig {
  String _url = "";
  int timeout = 5000;
  ServiceConfig(this._url, {this.timeout = 5000});
  
  Dio create() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        baseUrl: _url,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions request) async {
          
          //request.headers["token"] = "sa09f0dfkjfkashd"; - pode ser necessário um token para usar uma API, não é o nosso caso
          return request;
        },
        onResponse: (Response response) async {
          
          // Decript

          return response;
        },
        onError: (DioError error) async {
          return error;
        },
      ),
    );
    return dio;
  }
}
