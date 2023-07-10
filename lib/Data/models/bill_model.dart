import 'package:flutter/cupertino.dart';

class BillModel with ChangeNotifier {
  final String? id;
  final String billName;
  final String billTitle;
  final double billAmount;
  final String description;
  DateTime? createdAt;
  DateTime? dueDate;
  BillModel(
      {required this.id,
      required this.billName,
      required this.billAmount,
      required this.createdAt,
      required this.description,
      required this.dueDate,
      required this.billTitle});
}
