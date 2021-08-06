import 'package:flutter/material.dart';

class AlertDialogDeleteWidget extends StatelessWidget {
  final AlertDialogController controller;

  AlertDialogDeleteWidget(this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Konfirmasi Penghapusan'),
        content: Text('Apakah Anda yakin akan menghapus barang ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              controller.isConfirmed = true;

              Navigator.of(context).pop();
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }
}

class AlertDialogController {
  bool isConfirmed;

  AlertDialogController({this.isConfirmed});
}
