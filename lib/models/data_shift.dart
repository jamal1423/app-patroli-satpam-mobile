// ignore_for_file: non_constant_identifier_names, unused_element

class DataShift {
  int? id;
  String? kode_shift;
  String? nama_shift;
  String? jam_masuk;
  String? jam_pulang;

  DataShift({
    this.id,
    this.kode_shift,
    this.nama_shift,
    this.jam_masuk,
    this.jam_pulang,
  });

  DataShift.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    kode_shift = json["kode_shift"];
    nama_shift = json["nama_shift"];
    jam_masuk = json["jam_masuk"];
    jam_pulang = json["jam_pulang"];
    
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['kode_shift'] = kode_shift;
      data['nama_shift'] = nama_shift;
      data['jam_masuk'] = jam_masuk;
      data['jam_pulang'] = jam_pulang;
      return data;
    }
  }
}