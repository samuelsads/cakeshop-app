class Client {
  final String name;
  final String fatherSurname;
  final String? motherSurname;
  final String userId;
  final DateTime createdAt;
  final String uid;

  Client(
      {required this.name,
      required this.fatherSurname,
      this.motherSurname,
      required this.userId,
      required this.createdAt,
      required this.uid});
}
