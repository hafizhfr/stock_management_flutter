import 'package:flutter/material.dart';

loaderDialog(BuildContext context, Widget loaderIcon, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              Container(width: 50, height: 50, child: loaderIcon),
              Padding(padding: EdgeInsets.all(5)),
              Expanded(
                child: Text(
                  message,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                ),
              )
            ],
          ),
        );
      });
}

alertDialog(BuildContext context, String title, String message) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      });
}
