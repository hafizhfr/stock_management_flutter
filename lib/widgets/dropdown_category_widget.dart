import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownCategoryWidget extends StatefulWidget {
  final ItemCategoryController controller;
  final VoidCallback onSelected;
  final int screenType; // 1 = all item, 2 = edit item

  DropDownCategoryWidget({this.controller, this.onSelected, this.screenType});
  @override
  _DropDownCategoryWidget createState() => _DropDownCategoryWidget();
}

class _DropDownCategoryWidget extends State<DropDownCategoryWidget> {
  String _dropDownValue;

  @override
  void initState() {
    super.initState();
    widget.screenType == 2
        ? _dropDownValue = widget.controller.itemCategory
        : _dropDownValue = null;
  }

//bisa dipindah ke class lain
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
          // contentPadding: EdgeInsets.all(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text('Pilih Kategori ...'),
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
            onChanged: (newValue) {
              setState(() {
                _dropDownValue = newValue;
                widget.controller.itemCategory = _dropDownValue;
                widget.onSelected();
              });
            },
          ),
        ),
      ),
    );
  }
}

class ItemCategoryController {
  String itemCategory;

  ItemCategoryController({this.itemCategory});
}
