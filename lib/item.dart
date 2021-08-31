class Item {
  final String namaBarang;
  final int hargaBarang;
  final int jumlahBarang;
  final String kategori;

  Item({this.namaBarang, this.hargaBarang, this.jumlahBarang, this.kategori});

  static Item fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    return Item(
      hargaBarang: map['hargaBarang'],
      jumlahBarang: map['jumlahBarang'],
      kategori: map['kategori'],
      namaBarang: map['namaBarang'],
    );
  }
}
