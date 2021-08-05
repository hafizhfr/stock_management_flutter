import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/firebase_config/auth_services.dart';
import 'package:stock_management_flutter/page/dashboard_screen.dart';
import 'package:stock_management_flutter/page/register_screen.dart';

var fontFamily = 'Poppins';
Color a = Color(0xff25C266);
Color b = Color(0xff37dc9a);
Color c = Color(0xff33333F);
Color d = Color(0xff8E8E93);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width - 64;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Let’s Get\nStarted",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            SizedBox(
              height: 16,
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Container(
                  width: 250,
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/signup_illustration.jpg'),
                          fit: BoxFit.cover)),
                )),
            SizedBox(
              height: 16,
            ),
            Flexible(
                child: Container(
                    width: itemWidth,
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ))),
            SizedBox(
              height: 4,
            ),
            Flexible(
                child: Container(
                    child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'email',
                errorText: _validate ? 'Name Can\'t Be Empty' : null,
                labelStyle: TextStyle(color: a),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: a),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: a),
                ),
              ),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ))),
            SizedBox(
              height: 16,
            ),
            Flexible(
                child: Container(
                    width: itemWidth,
                    child: Text(
                      "Password",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.start,
                    ))),
            SizedBox(
              height: 4,
            ),
            Flexible(
                child: Container(
                    child: TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'password',
                errorText: _validate ? 'Password Can\'t Be Empty' : null,
                labelStyle: TextStyle(color: a),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: a),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: a),
                ),
              ),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ))),
            SizedBox(
              height: 32,
            ),
            Flexible(
                child: Container(
              height: 50,
              width: itemWidth,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)))),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontFamily: fontFamily,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    setState(() {
                      _validate = true;
                    });
                  } else {
                    User user = await AuthServices.signIn(
                        emailController.text, passwordController.text);
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        _validate = false;
                        return DashBoardScreen();
                      }));
                    } else {
                      setState(() {
                        _validate = true;
                      });
                    }
                  }
                },
              ),
            )),
            Flexible(
                child: Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 15),
                ),
                child: Text("Create An Account"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterScreen();
                  }));
                },
              ),
            ))
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
