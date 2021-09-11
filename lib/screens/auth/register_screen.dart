import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/common/dialog.dart';
import 'package:stock_management_flutter/common/styles.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthController _authController = Get.find();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                                .headline6!
                                .apply(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              inputText(
                                  hint: 'Full Name',
                                  formController: nameController),
                              SizedBox(
                                height: 16,
                              ),
                              inputText(
                                  hint: 'Email',
                                  formController: emailController),
                              SizedBox(
                                height: 16,
                              ),
                              inputText(
                                  hint: 'Password',
                                  obscureText: true,
                                  formController: passwordController),
                            ]),
                      ),
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
                              if (_formKey.currentState!.validate()) {
                                loaderDialog(context,
                                    CircularProgressIndicator(), "Please Wait");
                                _authController.signUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                          )),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
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
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: a),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: a),
            ),
          ),
          style: TextStyle(fontSize: 15, color: Colors.black),
          validator: (value) {
            if (value == null || value == '') {
              return '$hint can\'t be empty';
            } else if (hint == "Email" && !GetUtils.isEmail(value)) {
              return 'Email is not valid';
            } else if (hint == 'Password' && value.length < 6) {
              return 'Password must be at least 6 charater';
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
