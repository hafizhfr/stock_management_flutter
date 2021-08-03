import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var fontFamily = 'Poppins';
Color a = Color(0xff25C266);
Color b = Color(0xff37dc9a);
Color c = Color(0xff33333F);
Color d = Color(0xff8E8E93);

class DashBoardScreen extends StatelessWidget {
  final String email;
  final String password;

  DashBoardScreen({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
          elevation: 0,
          title: Text(
            'Welcome, $email',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 24,
            ),
          ),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return DashboardScreenMobile();
          }
        }));
  }
}

class DashboardScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: itemHeight * 4.5 / 10,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(32))),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Total Sales",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Rp.1.000.000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                        Container(width: 2, height: 48, color: Colors.amber,),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Stock In",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "200",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Container(width: 2, height: 48, color: Colors.amber,),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Stock Out",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "150",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
