import 'package:flutter/cupertino.dart';

import '../Data/models/bill_model.dart';

class BillProvider extends ChangeNotifier {
  final List<BillModel> _bills = [];

  List<BillModel> get bills {
    return [..._bills];
  }

  void addBill(BillModel bill) {
    var newBill = BillModel(
        billName: bill.billName,
        billAmount: bill.billAmount,
        createdAt: bill.createdAt,
        description: bill.description,
        dueDate: bill.dueDate,
        billTitle: bill.billTitle,
        id: DateTime.now().toString());
    _bills.add(newBill);
    notifyListeners();
  }
}
