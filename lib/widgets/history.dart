import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final items = List<String>.generate(10, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                  child: ListTile(
                    title: Text(items[index]),
                    subtitle: Text('28 Juli 2021 15:15'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
