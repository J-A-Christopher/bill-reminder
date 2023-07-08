class BillModel {
  final String title;
  final String description;
  DateTime createdAt;
  DateTime dueDate;
  BillModel(
      {required this.createdAt,
      required this.description,
      required this.dueDate,
      required this.title});
}
