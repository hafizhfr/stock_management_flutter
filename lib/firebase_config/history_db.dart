import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryCollection {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference collection = firestore.collection('history');
  static void addToDB(String itemName, String userFullName, int actionType) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateFormat timeFormat = DateFormat('HH:mm:ss');

    String currentDate = dateFormat.format(DateTime.now());
    String currentTime = timeFormat.format(DateTime.now());

    String userAction;
    if (actionType == 1) {
      userAction = 'menambahkan';
    } else if (actionType == 2) {
      userAction = 'mengubah';
    } else if (actionType == 3) {
      userAction = 'menghapus';
    }

    collection.add({
      'pesan': '$userFullName $userAction $itemName',
      'tanggal': '$currentDate',
      'waktu': '$currentTime',
    });
  }
}
