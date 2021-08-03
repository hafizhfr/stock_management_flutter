import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_management_flutter/auth_services.dart';
import 'package:stock_management_flutter/widgets/history.dart';
import 'package:stock_management_flutter/widgets/login_screen.dart';

var fontFamily = 'Poppins';
Color a = Colors.grey;
Color b = Colors.grey;
Color c = Colors.grey;
Color d = Colors.grey;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String email;
String password;
String fullName;

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
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
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputText(
                                label: 'Full Name',
                                formController: nameController),
                            inputText(
                                label: 'Email',
                                formController: emailController),
                            inputText(
                                label: 'Password',
                                obscureText: true,
                                formController: passwordController),
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () async {
                          if (nameController.text.isEmpty) {
                            setState(() {
                              _validate = true;
                            });
                          } else {
                            await AuthServices.signUp(nameController.text,
                                emailController.text, passwordController.text);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   _validate = false;
                            //   return HistoryScreen();
                            // }));
                          }
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputText({label, obscureText = false, formController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: formController,
          decoration: InputDecoration(
            errorText: _validate ? '$label can\'t be empty' : null,
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
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
