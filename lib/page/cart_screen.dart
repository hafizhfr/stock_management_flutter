import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_management_flutter/page/dashboard_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final items = List<String>.generate(3, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Cart"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    "Item Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.start,
                  )),
                  Expanded(
                      child: Text(
                    "QTY",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "Amount",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "name",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "qty",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            "Rp. amount",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.end,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: size.width,
                        height: 1,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 0,
                      width: 0,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "Total",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "Rp. 300.000",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.end,
                  )),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
              flex: 1,
                child: Container(
                  height: 50,
                  width: size.width * 2 / 3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)))),
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                          fontFamily: fontFamily,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: 'Transaksi Berhasil',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return DashBoardScreen();
                          }));
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
