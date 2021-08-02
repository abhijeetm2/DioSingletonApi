import 'package:api_integration_dio/http_service/client.dart';
import 'package:api_integration_dio/model_response/single_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UserDetailsProvider with ChangeNotifier {
  //...

  SingleUser? singleUser;
  Data? data;

  Future<Data?> getUser(String endpoint) async {
    //...
    Response response;
    try {
      response = await DioClient().getRequest('$endpoint');

      if (response.statusCode == 200) {
        singleUser = SingleUser.fromJson(response.data);
        notifyListeners();

        return data = singleUser!.data;
      } else {
        print('status is not 200');
      }
    } on Exception catch (e) {
      print(e);
    }

    // TODO
  }
}
