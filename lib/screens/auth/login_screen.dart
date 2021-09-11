import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/common/dialog.dart';
import 'package:stock_management_flutter/common/styles.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';
import 'package:stock_management_flutter/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // final double itemWidth = size.width - 64;
    var _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            physics:
                ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let’s Get\nStarted",
                      style: _textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/signup_illustration.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: Theme.of(context).textTheme.body1,
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(color: b),
                                  // ),
                                  // focusedBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(color: a),
                                  // ),
                                ),
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return 'Email can\'t be empty';
                                  } else if (!GetUtils.isEmail(value)) {
                                    return 'Email is not valid';
                                  }
                                },
                                style: _textTheme.subtitle1),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            child: TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: Theme.of(context).textTheme.body1,
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(color: a),
                                  // ),
                                  // focusedBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(color: a),
                                  // ),
                                ),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Password can\'t be empty';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 charater';
                                  }
                                },
                                style: _textTheme.subtitle1),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          // backgroundColor:
                          //     MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        if (_formKey.currentState!.validate()) {
                          loaderDialog(context, CircularProgressIndicator(),
                              "Please Wait");
                          _authController.signIn(
                              emailController.text, passwordController.text);
                        }
                      },
                    ),
                  ),
                  Container(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 15),
                      ),
                      child: Text("Create An Account"),
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
