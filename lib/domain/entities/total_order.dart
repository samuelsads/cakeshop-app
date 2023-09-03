class TotalOrder {
  final bool success;
  final int today;
  final int tomorrow;
  final int total;
  final String msg;

  TotalOrder(
      {required this.success,
      required this.today,
      required this.tomorrow,
      required this.total,
      this.msg = ""});
}
