class User {
  final String name;
  final String fatherSurname;
  final String? motherSurname;
  final String email;
  final int role;
  final String uid;

  User(
      {required this.name,
      required this.fatherSurname,
      this.motherSurname,
      required this.email,
      required this.role,
      required this.uid});
}
