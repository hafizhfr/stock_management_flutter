import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget{

  @override
  _DropDownWidget createState() => _DropDownWidget();
}

class _DropDownWidget extends State<DropDownWidget>{
  String _dropDownValue = "Makanan";
  @override
  Widget build(BuildContext context){
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.all(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _dropDownValue,
            isDense: true,
            isExpanded: true,
            items: [
              DropdownMenuItem(
                child: Text("Makanan"),
                value: "Makanan",
              ),
              DropdownMenuItem(
                child: Text("Alat Tulis"),
                value: "Alat Tulis",
              ),
              DropdownMenuItem(
                child: Text("Pakaian"),
                value: "Pakaian",
              ),
              DropdownMenuItem(
                child: Text("Minuman"),
                value: "Minuman",
              ),
              DropdownMenuItem(
                child: Text("Obat-obatan"),
                value: "Obat-obatan",
              ),
              DropdownMenuItem(
                child: Text("Peralatan Mandi"),
                value: "Peralatan Mandi",
              ),
              DropdownMenuItem(
                child: Text("Keperluan Bayi"),
                value: "Keperluan Bayi",
              ),
              DropdownMenuItem(
                child: Text("Lain-lain"),
                value: "Dan lain-lain",
              )
            ],
            onChanged: (newValue) {
              _dropDownValue = newValue;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}