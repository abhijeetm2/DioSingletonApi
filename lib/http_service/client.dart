import 'package:dio/dio.dart';

class DioClient {
  //...

  Dio? _dio;
  final baseUrl = 'https://reqres.in/';
  // final baseUrl = 'https://jsonplaceholder.typicode.com/';

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      //headers:  header part will used here
    ));
    intializeInterceptors();
  }

  //get request
  Future<Response> getRequest(String endpoint) async {
    //...
    Response response;
    try {
      response = await _dio!.get(endpoint);
      // print(response.data);
    } on Exception catch (e) {
      // TODO
      print(e);
      throw Exception(e);
    }
    return response;
  }

  intializeInterceptors() {
    //...
    _dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent

      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      // Do something with response data
      print(response);
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      // Do something with response error
      print(e);
      return handler.next(e); //continue
    }));
  }
}
