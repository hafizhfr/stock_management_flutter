class Item {
  String namaBarang;
  String kategori;
  int hargaBarang;
  int jumlahBarang;
  String img;

  Item(
      {required this.hargaBarang,
      required this.jumlahBarang,
      required this.kategori,
      required this.img,
      required this.namaBarang});

  static Item fromMap(Map<String, dynamic> map) {
    return Item(
      hargaBarang: map['hargaBarang'],
      jumlahBarang: map['jumlahBarang'],
      kategori: map['kategori'],
      namaBarang: map['namaBarang'],
      img: map['img'],
    );
  }
}
