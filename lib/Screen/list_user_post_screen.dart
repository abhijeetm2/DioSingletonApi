import 'package:api_integration_dio/model_response/data_users_img.dart';
import 'package:api_integration_dio/pdf_stuff/mobile.dart';
import 'package:api_integration_dio/providers/users_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ListUsersScreen extends StatefulWidget {
  @override
  _ListUsersScreenState createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  List<Data> userlist = [];
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersListprovider>(context, listen: false)
        .getUserlists('api/users');

    return Scaffold(
      appBar: AppBar(
        title: Text('ListUsers'),
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: () {
              final page =
                  Provider.of<UsersListprovider>(context, listen: false)
                      .getPerpage();
              _createPDF(userlist, page!);
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: users,
          builder: (ctx, snapshot) {
            //...
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final user = (snapshot.data as List<Data>)[index];
                      userlist.addAll(snapshot.data as List<Data>);

                      return ListTile(
                        title: Text(
                          user.firstName.toString(),
                        ),
                        leading: Image.network(user.avatar.toString()),
                        subtitle: Text(
                          user.email.toString(),
                        ),
                      );
                    },
                    itemCount: (snapshot.data as List<Data>).length,
                  )
                : Center(
                    child:
                        Text('Please check internet connection and try again!'),
                  );
          },
        ),
      ),
    );
  }

  Future<void> _createPDF(List<Data> userlist, int page) async {
    //....create pdf
    PdfDocument document = PdfDocument();
    //final page = document.pages.add();

    /*page.graphics
        .drawString('Welcome', PdfStandardFont(PdfFontFamily.helvetica, 30));*/

    PdfGrid grid = PdfGrid();
    grid.style =
        PdfGridStyle(font: PdfStandardFont(PdfFontFamily.helvetica, 30));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow headers = grid.headers[0];
    headers.cells[0].value = 'Id';
    headers.cells[1].value = 'first name';
    headers.cells[2].value = 'last name';

    PdfGridRow gridRows = grid.rows.add();

    for (int i = 0; i < userlist.length; i++) {
      //...
      //final user = userlist[i];
      print(' lists ${userlist.length.toString()}');
      if (i == page) break;
      gridRows.cells[0].value = userlist[i].id.toString();
      gridRows.cells[1].value = userlist[i].firstName;
      gridRows.cells[2].value = userlist[i].lastName;
      gridRows = grid.rows.add();
    }

/*    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'Shailesh';
    row.cells[2].value = 'Patil';

    row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = 'Abhijeet';
    row.cells[2].value = '16th';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = 'Abhijit';
    row.cells[2].value = 'patil';*/

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'output.pdf');
  }
}
