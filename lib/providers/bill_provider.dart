import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../Data/models/bill_model.dart';
import 'package:http/http.dart' as http;

class BillProvider extends ChangeNotifier {
  final List<BillModel> _bills = [];

  List<BillModel> get bills {
    return [..._bills];
  }

  Future<void> addBill(BillModel bill) async {
    var url = Uri.parse(
        'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': bill.billName,
            'description': bill.description,
            'amount': bill.billAmount,
            'duDate': bill.dueDate?.toIso8601String(),
            'createdAt': bill.createdAt?.toIso8601String()
          }));

      var newBill = BillModel(
          billName: bill.billName,
          billAmount: bill.billAmount,
          createdAt: bill.createdAt,
          description: bill.description,
          dueDate: bill.dueDate,
          billTitle: bill.billTitle,
          id: json.decode(response.body)['name']);
      _bills.add(newBill);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> fetchAndSetBills() async {
    var url = Uri.parse(
        'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills.json');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // extractedData.forEach((billId, billData) { })
    } catch (error) {
      rethrow;
    }
  }
}
