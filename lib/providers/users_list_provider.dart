import 'package:api_integration_dio/http_service/client.dart';
import 'package:api_integration_dio/model_response/data_users_img.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UsersListprovider with ChangeNotifier {
  //..
  DataUsersImg? listUserresponse;

  List<Data>? users;

  int? page;

  Future<List<Data>?> getUserlists(String endpoint) async {
    //...
    Response response;
    try {
      response = await DioClient().getRequest('$endpoint');

      if (response.statusCode == 200) {
        listUserresponse = DataUsersImg.fromJson(response.data);
        users = listUserresponse?.data;
        notifyListeners();
        page = listUserresponse?.perPage as int;
        return users;
      } else {
        print('status is not 200');
      }
    } on Exception catch (e) {
      print('provider $e');
    }
  }

  int? getPerpage() {
    //...
    notifyListeners();
    return page;
  }
}
