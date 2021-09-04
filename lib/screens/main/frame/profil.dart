import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Rx<bool> isEnableTextField = false.obs;
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();

  final AuthController _authController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = _authController.user.displayName!;
    emailController.text = _authController.user.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        automaticallyImplyLeading: false,
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
                                isEnableTextField.value =
                                    !isEnableTextField.value;
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
                      Obx(
                        () => TextField(
                            enabled: isEnableTextField.value,
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              hintText: "Full Name",
                              // errorText: _validate ? 'Password Can\'t Be Empty' : null,
                            ),
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => TextField(
                            enabled: isEnableTextField.value,
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              hintText: "xxxxx@mail.com",
                              // errorText: _validate ? 'Password Can\'t Be Empty' : null,
                            ),
                            style: Theme.of(context).textTheme.headline6),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Obx(
                    () => Visibility(
                        visible: isEnableTextField.value,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (nameController.text.isEmpty ||
                                emailController.text.isEmpty) {
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Profile berhasil diupdate');
                              isEnableTextField.value = false;
                            }
                          },
                          child: Text('Update Profile'),
                        )),
                  ),
                  Obx(
                    () => Visibility(
                      visible: !isEnableTextField.value,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () async {
                          _authController.signOut();
                        },
                        child: Text('Logout'),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      // ),
    );
  }
}
