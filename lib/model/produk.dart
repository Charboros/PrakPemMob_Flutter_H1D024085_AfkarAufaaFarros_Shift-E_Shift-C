class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;

  Produk({this.id, this.kodeProduk, this.namaProduk, this.hargaProduk});

  factory Produk.fromJson(Map<String, dynamic> obj) {
    var rawId = obj['id'];
    var rawHarga = obj['harga'];
    return Produk(
      id: rawId is int
          ? rawId
          : (rawId != null ? int.tryParse(rawId.toString()) : null),
      kodeProduk: obj['kode_produk']?.toString(),
      namaProduk: obj['nama_produk']?.toString(),
      hargaProduk: rawHarga is int
          ? rawHarga
          : (rawHarga != null ? int.tryParse(rawHarga.toString()) : null),
    );
  }
}
