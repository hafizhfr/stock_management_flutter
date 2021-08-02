import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var fontFamily = 'Poppins';
Color a = Colors.grey;
Color b = Colors.grey;
Color c = Colors.grey;
Color d = Colors.grey;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sign up to get started",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    // Container(
                    //   child: Image.asset(
                    //     'images/signup_illustration.jpg',
                    //     width: 200,
                    //   ),
                    // ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Name can\'t be empty' : null,
                              labelStyle: TextStyle(color: a),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: a),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: a),
                              ),
                            ),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Email can\'t be empty' : null,
                              labelStyle: TextStyle(color: a),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: a),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: a),
                              ),
                            ),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Password can\'t be empty' : null,
                              labelStyle: TextStyle(color: a),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: a),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: a),
                              ),
                            ),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ]),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: b),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontFamily: fontFamily,
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          setState(() {
                            _validate = true;
                          });
                        } else {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   _validate = false;
                          //   return MainScreen(text: myController.text);
                          // }));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
