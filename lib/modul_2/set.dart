import 'dart:io';

void main() {

  // Data awal
  Set<String> dataSet = {'a', 'b', 'c', 'd', 'e'};

  print("=== SEMUA DATA ===");

  int no = 1;
  for (var item in dataSet) {
    print("$no. $item");
    no++;
  }

  print("Total data: ${dataSet.length}");

  // Tambah data
  stdout.write("\nMasukkan data baru: ");
  String tambah = stdin.readLineSync()!;
  dataSet.add(tambah);
  print('Data "$tambah" berhasil ditambahkan!');

  // Hapus data
  stdout.write("\nMasukkan data yang ingin dihapus: ");
  String hapus = stdin.readLineSync()!;
  if (dataSet.contains(hapus)) {
    dataSet.remove(hapus);
    print('Data "$hapus" berhasil dihapus!');
  } else {
    print('Data "$hapus" tidak ditemukan!');
  }

  // Cek data
  stdout.write("\nMasukkan data yang ingin dicek: ");
  String cek = stdin.readLineSync()!;
  if (dataSet.contains(cek)) {
    print('Data "$cek" ada di Set');
  } else {
    print('Data "$cek" tidak ada di Set');
  }

}