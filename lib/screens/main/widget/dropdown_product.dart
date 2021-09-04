import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownProductWidget extends StatefulWidget {
  final ItemProductController controller;

  DropDownProductWidget(this.controller);

  @override
  _DropDownProductWidget createState() => _DropDownProductWidget();
}

class _DropDownProductWidget extends State<DropDownProductWidget> {
  String _dropDownValue = "Makanan";
  late String productName;
  List<String> kategoriBarang = [
    'Makanan',
    'Alat Tulis',
    'Pakaian',
    'Minuman',
    'Obat-obatan',
    'Peralatan Mandi',
    'Keperluan Bayi',
    'Lain-lain',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: EdgeInsets.all(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _dropDownValue,
            isDense: true,
            isExpanded: true,
            items:
            kategoriBarang.map<DropdownMenuItem<String>>((String kategori) {
              return DropdownMenuItem(
                child: Text(kategori),
                value: kategori,
              );
            }).toList(),
            // DropdownMenuItem(
            //   child: Text("Makanan"),
            //   value: "Makanan",
            // ),
            // DropdownMenuItem(
            //   child: Text("Alat Tulis"),
            //   value: "Alat Tulis",
            // ),
            // DropdownMenuItem(
            //   child: Text("Pakaian"),
            //   value: "Pakaian",
            // ),
            // DropdownMenuItem(
            //   child: Text("Minuman"),
            //   value: "Minuman",
            // ),
            // DropdownMenuItem(
            //   child: Text("Obat-obatan"),
            //   value: "Obat-obatan",
            // ),
            // DropdownMenuItem(
            //   child: Text("Peralatan Mandi"),
            //   value: "Peralatan Mandi",
            // ),
            // DropdownMenuItem(
            //   child: Text("Keperluan Bayi"),
            //   value: "Keperluan Bayi",
            // ),
            // DropdownMenuItem(
            //   child: Text("Lain-lain"),
            //   value: "Dan lain-lain",
            // )

            onChanged: (newValue) {
              setState(() {
                _dropDownValue = newValue!;
                widget.controller.itemProduct = _dropDownValue;
              });
            },
          ),
        ),
      ),
    );
  }

// getProductName() async {
//   String currId = await auth
// }
}

class ItemProductController {
  String itemProduct;

  ItemProductController({this.itemProduct = ''});
}
