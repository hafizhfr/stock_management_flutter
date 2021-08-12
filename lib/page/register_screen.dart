import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_management_flutter/firebase_config/auth_services.dart';
import 'package:stock_management_flutter/main.dart';
import 'package:stock_management_flutter/page/login_screen.dart';
import 'package:stock_management_flutter/widgets/styles.dart';

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
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Sign up to get started",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .apply(color: Colors.grey),
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
                                hint: 'Full Name',
                                formController: nameController),
                            SizedBox(
                              height: 16,
                            ),
                            inputText(
                                hint: 'Email', formController: emailController),
                            SizedBox(
                              height: 16,
                            ),
                            inputText(
                                hint: 'Password',
                                obscureText: true,
                                formController: passwordController),
                          ]),
                      SizedBox(
                        height: 40,
                      ),

                      Container(
                          height: 50,
                          width: 300,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.grey)))),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (nameController.text.isEmpty) {
                                setState(() {
                                  _validate = true;
                                });
                              } else {
                                await AuthServices.signUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text);
                                //zzzzzzzzzzzzzzzzzzzzzzzzzzzzz
                                User user = AuthServices.getUser();
                                print(user.uid);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MyHomePage();
                                    },
                                  ),
                                );
                              }
                            },
                          )),
                      
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

  Widget inputText({hint, obscureText = false, formController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: obscureText,
          controller: formController,
          decoration: InputDecoration(
            hintText: '$hint',
            hintStyle: Theme.of(context).textTheme.body1,
            errorText: _validate ? '$hint can\'t be empty' : null,
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
