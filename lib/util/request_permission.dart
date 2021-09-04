import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission p) async {
  if (await p.isGranted) {
    return true;
  } else {
    var result = await p.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
