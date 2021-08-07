import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEnableTextField = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFILE",
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8zpfdzQKEDKixZ57SDbZz-BY-Wj94ZcUo0w&usqp=CAU'),
                          ),
                          Positioned(
                              bottom: 5,
                              right: 5,
                              child: InkWell(
                                // borderRadius: BorderRadius.all(Radius.circular(60)),
                                onTap: () {
                                  setState(() {
                                    isEnableTextField = !isEnableTextField;
                                  });
                                },
                                child: ClipOval(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        color: Colors.blue,
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      )),
                  SizedBox(
                    height: 70,
                  ),
                  Expanded(
                      child: Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: TextField(
                      enabled: isEnableTextField,
                      // controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: "Full Name",
                        // errorText: _validate ? 'Password Can\'t Be Empty' : null,
                      ),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )),
                  Expanded(
                      child: Card(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: TextField(
                      enabled: isEnableTextField,
                      // controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        hintText: "xxxxx@mail.com",
                        // errorText: _validate ? 'Password Can\'t Be Empty' : null,
                      ),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )),
                  SizedBox(
                    height: 70,
                  ),
                  Expanded(
                    child: Visibility(
                        visible: isEnableTextField,
                        child: RaisedButton(
                          padding: EdgeInsets.only(left: 70, right: 70),
                          onPressed: () {},
                          color: Colors.blue,
                          child: Text('Edit Profile'),
                        )),
                  ),
                  Expanded(
                      child: Visibility(
                          visible: !isEnableTextField,
                          child: RaisedButton(
                            onPressed: () {},
                            color: Colors.red,
                            child: Text('Logout'),
                          )))
                ]),
          ),
        ),
      ),
    ));
  }

  void isEditable() {
    isEnableTextField = !isEnableTextField;
  }
}
