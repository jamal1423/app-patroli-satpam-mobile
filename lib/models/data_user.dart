// ignore_for_file: non_constant_identifier_names

class Datauser {
  int? id;
  String? fullname;
  String? employeeID;
  String? role;
  String? gender;
  String? foto;

  Datauser({
    this.id,
    this.fullname,
    this.employeeID,
    this.role,
    this.gender,
    this.foto,
  });

  factory Datauser.fromJson(Map<String, dynamic> json) {
    return Datauser(
      id: json['id'],
      fullname: json['fullname'],
      employeeID: json['employeeID'],
      role: json['role'],
      gender: json['gender'],
      foto: json['foto'],
    );
  }
}
