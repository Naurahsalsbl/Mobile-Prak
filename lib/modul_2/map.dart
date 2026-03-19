import 'dart:io';

void main() {
    Map<String, String> data = {
        'Anang' : '081234567890',
        'Arman' : '082345678901',
        'Doni' : '083456789012',
    };
    print('Data: $data');

    data['Rio'] = '084567890123';
    print('Data setelah ditambahkan: $data');

    print('Nomor Anang: ${data['Anang']}');

    stdout.write("\nMasukkan nama yang ingin diubah: ");
    String namaUbah = stdin.readLineSync()!;

    if (data.containsKey(namaUbah)) {
    stdout.write("Masukkan nomor baru: ");
    String nomorBaru = stdin.readLineSync()!;
    data[namaUbah] = nomorBaru;
    print("Data berhasil diubah!");
    } else {
    print("Nama tidak ditemukan!");
    }

    stdout.write("\nMasukkan nama yang ingin dihapus: ");
    String namaHapus = stdin.readLineSync()!;

    if (data.containsKey(namaHapus)) {
    data.remove(namaHapus);
    print("Data berhasil dihapus!");
    } else {
    print("Nama tidak ditemukan!");
    }

    stdout.write("\nMasukkan nama yang ingin dicek: ");
    String namaCek = stdin.readLineSync()!;

    if (data.containsKey(namaCek)) {
    print("Nomor ${namaCek}: ${data[namaCek]}");
    } else {
    print("Nama tidak ada di data!");
    }

    print("\nTotal data: ${data.length}");

    print("\nSemua nama:");
    print(data.keys);

    print("\nSemua nomor:");
    print(data.values);

    print("=== INPUT DATA MAHASISWA ===");

    stdout.write("Masukkan NIM: ");
    String nim = stdin.readLineSync()!;

    stdout.write("Masukkan Nama: ");
    String nama = stdin.readLineSync()!;

    stdout.write("Masukkan Jurusan: ");
    String jurusan = stdin.readLineSync()!;

    stdout.write("Masukkan IPK: ");
    String ipk = stdin.readLineSync()!;

    Map<String, String> mahasiswa = {
        'nim': nim,
        'nama': nama,
        'jurusan': jurusan,
        'ipk': ipk
    };

    print("\nData Mahasiswa: $mahasiswa");

    print("=== INPUT MULTIPLE MAHASISWA ===");

    stdout.write("Masukkan jumlah mahasiswa: ");
    int jumlah = int.parse(stdin.readLineSync()!);

    List<Map<String, String>> daftarMahasiswa = [];

    for (int i = 0; i < jumlah; i++) {

        print("\n--- Mahasiswa ke-${i+1} ---");

        stdout.write("Masukkan NIM: ");
        String nim = stdin.readLineSync()!;

        stdout.write("Masukkan Nama: ");
        String nama = stdin.readLineSync()!;

        stdout.write("Masukkan Jurusan: ");
        String jurusan = stdin.readLineSync()!;

        stdout.write("Masukkan IPK: ");
        String ipk = stdin.readLineSync()!;

        Map<String, String> mahasiswa = {
        'nim': nim,
        'nama': nama,
        'jurusan': jurusan,
        'ipk': ipk
        };

        daftarMahasiswa.add(mahasiswa);
    }

    print("\n=== SEMUA DATA MAHASISWA ===");

    for (int i = 0; i < daftarMahasiswa.length; i++) {
        print("Mahasiswa ke-${i+1}: ${daftarMahasiswa[i]}");
    }
}

