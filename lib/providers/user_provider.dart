import 'package:api_integration_dio/http_service/client.dart';
import 'package:api_integration_dio/model_response/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  //..

  List<User> _userData = [];

  Future<List<User>> fetchUsers() async {
    Response response;
    try {
      /* response =
          await Dio().get('${DioClient.baseUrl2}users');*/

      response = await DioClient().getRequest('users');

      if (response.statusCode == 200) {
        var getUsersData = response.data as List;
        _userData = getUsersData.map((i) => User.fromJson(i)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
    }
    return _userData;
  }
}
