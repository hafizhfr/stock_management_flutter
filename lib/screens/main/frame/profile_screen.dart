import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/common/dialog.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Rx<bool> isEnableTextField = false.obs;
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();

  final AuthController _authController = Get.find();

  @override
  void initState() {
    nameController.text = _authController.user!.displayName!;
    emailController.text = _authController.user!.email!;
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
                        Obx(
                          () => CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8zpfdzQKEDKixZ57SDbZz-BY-Wj94ZcUo0w&usqp=CAU'),
                            child: Visibility(
                              visible: AuthController.photoUrl.value != "",
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      AuthController.photoUrl.value),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: InkWell(
                                onTap: () {
                                  isEnableTextField.value =
                                      !isEnableTextField.value;
                                },
                                child: Column(
                                  children: [
                                    Obx(() => Visibility(
                                        visible: isEnableTextField.value,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white)),
                                          child: IconButton(
                                            onPressed: () {
                                              _showPicker(context);
                                            },
                                            icon: Icon(
                                              Icons.camera_alt_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))),
                                    Obx(() => Visibility(
                                          visible: !isEnableTextField.value,
                                          child: ClipOval(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(40)),
                                                  color: Colors.blue,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2)),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                )))
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
                              loaderDialog(context, CircularProgressIndicator(),
                                  "Menyimpan perubahan...");
                              await _authController.updateUser(
                                  nameController.text, emailController.text);
                              Navigator.pop(context);
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
    );
  }

  void _showPicker(context) {
    var i = 0;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        i = 1;
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      i = 2;
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text('Hapus'),
                    onTap: () {
                      i = 3;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }).then((value) async {
      if (i == 1) {
        if (!await _authController.imgFromGallery(context)) {
          Fluttertoast.showToast(
            msg: 'Gagal, belum ada izin',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      }
      if (i == 2) {
        if (!await _authController.imgFromCamera(context)) {
          Fluttertoast.showToast(
            msg: 'Gagal, belum ada izin',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      }
      if (i == 3 && _authController.user!.photoURL != null) {
        _authController.user!.updatePhotoURL(null);
        AuthController.photoUrl.value = "";
        var firebaseStorage = FirebaseStorage.instance;
        await firebaseStorage
            .ref('uploads/${_authController.user!.uid}.png')
            .delete();
      }
      i = 0;
    });
  }
}
