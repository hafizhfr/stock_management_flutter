import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/common/styles.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('History'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseServices.getHistoryStream(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.size == 0) {
                  return Center(
                      child: Text(
                    'Data isEmpty',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: fontFamily,
                    ),
                  ));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index]['pesan']),
                      subtitle: Text(
                          '${snapshot.data!.docs[index]['tanggal']} -- ${snapshot.data!.docs[index]['waktu']}'),
                    ),
                  ),
                );
              }

              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
