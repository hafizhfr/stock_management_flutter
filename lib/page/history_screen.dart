import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/firebase_config/history_db.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // final items = List<String>.generate(10, (i) => "Item $i");

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
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: HistoryCollection.collection
                    .orderBy('tanggal', descending: true)
                    .orderBy('waktu', descending: true)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs.map((document) {
                        return Card(
                            child: ListTile(
                          title: Text(document['pesan']),
                          subtitle: Text(
                              '${document['tanggal']} -- ${document['waktu']}'),
                        ));
                      }).toList(),
                    );
                  }
                  return CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
