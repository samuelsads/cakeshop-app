class UserUserDB {
  final String name;
  final String fatherSurname;
  final String? motherSurname;
  final String email;
  final int role;
  final String uid;

  UserUserDB(
      {required this.name,
      required this.fatherSurname,
      this.motherSurname,
      required this.email,
      required this.role,
      required this.uid});

  factory UserUserDB.fromJson(Map<String, dynamic> json) => UserUserDB(
        name: json["name"],
        fatherSurname: json["father_surname"],
        motherSurname: json["mother_surname"],
        email: json["email"],
        role: json["role"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "father_surname": fatherSurname,
        "mother_surname": motherSurname,
        "email": email,
        "role": role,
        "uid": uid,
      };
}
