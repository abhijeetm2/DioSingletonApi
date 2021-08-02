import 'package:api_integration_dio/model_response/user.dart';
import 'package:api_integration_dio/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  Future _obtainOrdersFuture() {
    return Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserDetails'),
      ),
      body: FutureBuilder(
        future: _obtainOrdersFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.hasData
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    var user = (snapshot.data as List<User>)[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                          SizedBox(),
                          Text('${user.email}'),
                          SizedBox(),
                          Text(
                              '${user.address}  ${user.address!.suite}  ${user.address!.city}'),
                          SizedBox(),
                          Text('${user.phone}'),
                          SizedBox(),
                          Text('${user.website}'),
                          SizedBox(),
                          Text('${user.company!.name}'),
                          SizedBox(),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider();
                  },
                  itemCount: (snapshot.data as List<User>).length)
              : Text('No data found');
        },
      ),
    );
  }
}
