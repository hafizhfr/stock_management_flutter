import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/firebase_config/auth_services.dart';
import 'package:stock_management_flutter/page/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen(this.user);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEnableTextField = false;
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.displayName;
    emailController.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFILE",
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          padding: EdgeInsets.only(top: 100),
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
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
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      TextField(
                        enabled: isEnableTextField,
                        controller: nameController,
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
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        enabled: isEnableTextField,
                        controller: emailController,
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
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Visibility(
                      visible: isEnableTextField,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty) {
                          } else {
                            await AuthServices.updateUser(
                                nameController.text, emailController.text);
                          }
                        },
                        child: Text('Update Profile'),
                      )),
                  Visibility(
                    visible: !isEnableTextField,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      // ),
    );
  }

  void isEditable() {
    isEnableTextField = !isEnableTextField;
  }
}
