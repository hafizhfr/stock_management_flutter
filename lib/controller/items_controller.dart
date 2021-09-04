import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_management_flutter/data/models/item_model.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';

class ItemsController extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    _totalSales.bindStream(FirebaseServices.getTotalSales());
    _stockOut.bindStream(FirebaseServices.getStockOut());
    _totalStock.bindStream(FirebaseServices.getCurrentStockut());
    super.onInit();
  }

  final _totalStock = 0.obs;
  int get getTotalStock => _totalStock.value;
  final _stockOut = 0.obs;
  int get getStockOut => _stockOut.value;
  final _totalSales = 0.obs;
  int get getTotalSales => _totalSales.value;

  List<String> _itemNameList = [];
  List<String> get itemNameList => _itemNameList;
  List<int> _itemPriceList = [];
  List<int> get itemPriceList => _itemPriceList;
  List<int> _itemCountList = [];
  List<int> get itemCountList => _itemCountList;
  List<Item> getListItem = [];
  var _totalPrice = 0.obs;
  int get totalPrice => _totalPrice.value;
  set totalPrice(value) => _totalPrice.value = value;

  Stream<QuerySnapshot> itemList(String search, String kategori) {
    if (kategori == 'All') {
      kategori = '';
    }
    return search == ''
        ? kategori == ''
            ? FirebaseServices.itemCollection.orderBy('namaBarang').snapshots()
            : FirebaseServices.itemCollection
                .where('kategori', isEqualTo: kategori)
                .orderBy('namaBarang')
                .snapshots()
        : kategori == ''
            ? FirebaseServices.itemCollection
                .where('namaBarang', isGreaterThanOrEqualTo: search)
                .orderBy('namaBarang')
                .snapshots()
            : FirebaseServices.itemCollection
                .where('namaBarang', isGreaterThanOrEqualTo: search)
                .where('kategori', isEqualTo: kategori)
                .orderBy('namaBarang')
                .snapshots();
  }

  Future<List<Item>> getItemList() async {
    var result = await FirebaseServices.getItemListOnce();
    itemNameList.clear();
    itemPriceList.clear();
    itemCountList.clear();
    getListItem.clear();
    result.forEach((element) {
      itemNameList.add(element.namaBarang);
      itemPriceList.add(element.hargaBarang);
      itemCountList.add(element.jumlahBarang);
    });
    return result;
  }

  Future<void> deleteItem(String name, int stock) async {
    await FirebaseServices.deleteItems(name);
    Fluttertoast.showToast(
        msg: 'Berhasil menghapus $name',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
    await FirebaseServices.addHistory(
        name, FirebaseServices.user.displayName!, 3);
    await FirebaseServices.updateTotalStock(stock, 2, getTotalStock);
  }

  addCart(String name, String cat, int price, int count, int totalCount) async {
    var list = await storage.read('cart');
    if (list == null) {
      await storage.write('cart', [
        {
          'name': name,
          'price': price,
          'count': count,
          'cat': cat,
        }
      ]);
    } else {
      list.add({
        'name': name,
        'price': price,
        'count': count,
        'cat': cat,
      });
      storage.write('cart', list);
    }
    await FirebaseServices.updateStock(name, cat, totalCount - count);
  }

  Future<List> getCart() async {
    var list = await storage.read('cart');
    if (list == null) {
      list = [];
    }
    totalPrice = 0;
    for (var item in list) {
      totalPrice += item['price'] as int;
    }
    return list as List;
  }

  Future<void> cancelCart() async {
    var list = await storage.read('cart');
    if (list == null) {
      list = [];
    }
    for (var item in list) {
      var data = await FirebaseServices.itemCollection
          .doc(("${item['name']}-${item['cat']}").toLowerCase())
          .get();
      await FirebaseServices.updateStock(
          item['name'], item['cat'], data['jumlahBarang'] + item['count']);
    }
    await storage.write('cart', null);
  }

  Future<void> confirmCart() async {
    var list = await storage.read('cart');
    if (list == null) {
      list = [];
    }
    for (var item in list) {
      await FirebaseServices.updateTotalStock(item['count'], 1, getTotalStock);
      await FirebaseServices.updateStockOut(item['count'], getStockOut);
      await FirebaseServices.updateTotalSales(item['price'], getTotalSales);
    }
    await storage.write('cart', null);
  }
}
