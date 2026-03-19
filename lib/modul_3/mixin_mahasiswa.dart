class Mahasiswa {
    String? nama;
    String? nim;

    void tampilkanData() {
        print("Nama: $nama");
        print("NIM: $nim");
    }
}

mixin Mengajar {
    void mengajar() {
        print("Sedang mengajar mahasiswa.");
    }
}

mixin Penelitian {
    void penelitian() {
        print("Sedang melakukan penelitian.");
    }
}

mixin Administrasi {
    void administrasi() {
        print("Sedang mengurus administrasi fakultas.");
    }
}

class Dosen extends Mahasiswa
    with Mengajar, Penelitian, Administrasi {

    String? mataKuliah;

    void infoDosen() {
    print("$nama mengajar mata kuliah $mataKuliah");
  }
}

class Fakultas extends Mahasiswa
    with Administrasi {

    String? namaFakultas;

    void infoFakultas() {
    print("$nama bekerja di fakultas $namaFakultas");
  }
}

void main() {
    Dosen dosen = Dosen();
    dosen.nama = "Pak Budi";
    dosen.nim = "D001";
    dosen.mataKuliah = "Aplikasi Mobile";

    dosen.tampilkanData();
    dosen.infoDosen();
    dosen.mengajar();
    dosen.penelitian();

    print("--------------");

    Fakultas fakultas = Fakultas();
    fakultas.nama = "Farah";
    fakultas.nim = "F001";
    fakultas.namaFakultas = "Vokasi";

    fakultas.tampilkanData();
    fakultas.infoFakultas();
    fakultas.administrasi();
}
