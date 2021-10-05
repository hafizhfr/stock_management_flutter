import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownCategoryWidget extends StatefulWidget {
  final ItemCategoryController controller;
  final VoidCallback onSelected;
  final int screenType; // 1 = all item, 2 = edit item

  DropDownCategoryWidget(
      {required this.controller,
      required this.onSelected,
      required this.screenType});
  @override
  _DropDownCategoryWidget createState() => _DropDownCategoryWidget();
}

class _DropDownCategoryWidget extends State<DropDownCategoryWidget> {
  late String _dropDownValue;

  @override
  void initState() {
    super.initState();
    if (widget.screenType == 1) {
      _dropDownValue = kategoriBarang.first;
    } else {
      kategoriBarang.remove("All");
      _dropDownValue = kategoriBarang.first;
    }
  }

  List<String> kategoriBarang = [
    'All',
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
                _dropDownValue = newValue!;
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

  ItemCategoryController({required this.itemCategory});
}
