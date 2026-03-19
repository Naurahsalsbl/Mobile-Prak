import 'dart:io';

// class Mahasiswa {
//     String nama = "Anang";

//     void tampilkanData() {
//         print(nama);
//     }
// }

// void main() {
//     var mahasiswa1 = Mahasiswa();
//     mahasiswa1.tampilkanData();

//     stdout.write("Masukkan nama baru: ");
//     String? namaBaru = stdin.readLineSync();
//     if (namaBaru != null && namaBaru.isNotEmpty) {
//         mahasiswa1.nama = namaBaru;
//         print("Nama berhasil diubah.");
//         mahasiswa1.tampilkanData();
//     } else {
//         print("Nama tidak boleh kosong.");
//     }
// }



class Mahasiswa {
    String? nama;
    int? nim;
    String? jurusan;

    void tampilkanData() {
        print("Nama: ${nama ?? 'Belum diisi'}");
        print("NIM: ${nim ?? 'Belum diisi'}");
        print("Jurusan: ${jurusan ?? 'Belum diisi'}");
    }
}

void main() {
    Mahasiswa mahasiswa = Mahasiswa();
    print("Masukkan Nama Mahasiswa:");
    mahasiswa.nama = stdin.readLineSync();
    print("Masukkan NIM Mahasiswa:");
    mahasiswa.nim = int.tryParse(stdin.readLineSync() ?? '');
    print("Masukkan Jurusan Mahasiswa:");
    mahasiswa.jurusan = stdin.readLineSync();
    mahasiswa.tampilkanData();
}