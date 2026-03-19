import 'dart:io';

void main() {
    List<String> names = ['Alfa', 'Beta', 'Charlie'];
    print('Names: $names');

    names.add('Delta');
    print('Names setelah ditambahkan: $names');

    print('Elemen pertama: ${names[0]}');
    print('Elemen kedua: ${names[1]}');

    names[1] = 'Bravo';
    print('Names setelah diubah: $names');

    names.remove('Charlie');
    print('Names setelah dihapus: $names');

    print('Jumlah data: ${names.length}');

    print('Menampilkan setiap elemen: ');
    for (String name in names) {
        print(name);
    }

    List<String> dataList = [];
    print('Data list kosong: $dataList');

    int count = 0;
    while (count <= 0) {
        stdout.write('Masukkan jumlah list: ');
        String? input = stdin.readLineSync();
        try {
            count = int.parse(input!);
            if (count <=0) {
                print('Masukkan angka lebih dari 0!');
            }
        } catch (e) {
            print('Input tidak valid! Masukkan angka yang benar.');
        }
    }

    for (int i = 0; i < count; i++) {
        stdout.write('data ke-${i+1}: ');
        String x = stdin.readLineSync()!;
        dataList.add(x);

         print('Data list: ');
         print(dataList);
    }

    stdout.write('\nMasukkan index yang ingin ditampilkan: ');
    int indexTampil = int.parse(stdin.readLineSync()!);

    if (indexTampil >= 0 && indexTampil < dataList.length) {
        print('Data pada index $indexTampil: ${dataList[indexTampil]}');
    } else {
        print('Index tidak valid!');
    }

    stdout.write('\nMasukkan index yang ingin diubah: ');
    int indexUbah = int.parse(stdin.readLineSync()!);

    if (indexUbah >= 0 && indexUbah < dataList.length) {
        stdout.write('Masukkan data baru: ');
        String dataBaru = stdin.readLineSync()!;
        dataList[indexUbah] = dataBaru;
        print('Data setelah diubah: $dataList');
    } else {
        print('Index tidak valid!');
    }

    stdout.write('\nMasukkan index yang ingin dihapus: ');
    int indexHapus = int.parse(stdin.readLineSync()!);

    if (indexHapus >= 0 && indexHapus < dataList.length) {
        dataList.removeAt(indexHapus);
        print('Data setelah dihapus: $dataList');
    } else {
        print('Index tidak valid!');
    }

    print('\nHasil akhir list: $dataList');
    for (int i = 0; i < dataList.length; i++) {
    print('Index $i : ${dataList[i]}');
    }

    print('Jumlah data akhir: ${dataList.length}');

}
