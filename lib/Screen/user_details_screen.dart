import 'package:api_integration_dio/model_response/single_user.dart';
import 'package:api_integration_dio/providers/user_detailsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  SingleUser? singleUser;
  Data? data;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserDetailsProvider>(context, listen: false)
        .getUser('api/users/2');

    return Scaffold(
      appBar: AppBar(
        title: Text('UserDetails'),
      ),
      body: Column(
        children: [
          //...
          Center(
            child: FutureBuilder<Data?>(
              future: users,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? snapshot.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(snapshot.data?.firstName ?? 'no data found'),
                              SizedBox(height: 20),
                              Text(snapshot.data?.lastName ?? 'no data found'),
                              SizedBox(height: 20),
                              Text(snapshot.data?.email ?? 'no data found'),
                              SizedBox(height: 20),
                            ],
                          )
                    : Center(
                        child: Text('Some thing went wrog'),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
