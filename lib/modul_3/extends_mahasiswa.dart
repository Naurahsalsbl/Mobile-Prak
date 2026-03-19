class Mahasiswa {
    String? nama;
    String? nim;
    String? jurusan;

    void tampilkanData() {
        print("Nama: $nama");
        print("NIM: $nim");
        print("Jurusan: $jurusan");
    }
}

class mahasiswaAktif extends Mahasiswa {
    int? semester;

    void tampilkanStatus() {
        print("$nama adalah mahasiswa aktif semester $semester");
    }
}

class mahasiswaAlumni extends Mahasiswa {
    int tahunLulus = 0;

    void infoAlumni() {
        print("$nama sudah lulus pada tahun $tahunLulus");
    }
}

void main() {
    mahasiswaAktif aktif = mahasiswaAktif();
    aktif.nama = "Naurah";
    aktif.nim = "123456";
    aktif.jurusan = "Teknik Informatika";
    aktif.semester = 4;

    aktif.tampilkanData();
    aktif.tampilkanStatus();

    print("-----------");

    mahasiswaAlumni alumni = mahasiswaAlumni();
    alumni.nama = "Rendra";
    alumni.nim = "632786";
    alumni.jurusan = "Teknik Informatika";
    alumni.tahunLulus = 2023;

    alumni.tampilkanData();
    alumni.infoAlumni();
}