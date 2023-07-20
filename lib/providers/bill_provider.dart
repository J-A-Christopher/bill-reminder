import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../Data/models/bill_model.dart';
import 'package:http/http.dart' as http;

class BillProvider extends ChangeNotifier {
  List<BillModel> _bills = [];

  List<BillModel> get bills {
    return [..._bills];
  }

  Future<void> updateProduct(String id, BillModel billModel) async {
    final billIndex = _bills.indexWhere((bill) => bill.id == id);

    if (billIndex >= 0) {
      var url = Uri.parse(
          'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': billModel.billName,
            'description': billModel.description,
            'amount': billModel.billAmount,
            'dueDate': billModel.dueDate?.toIso8601String(),
            'createdAt': billModel.createdAt?.toIso8601String()
          }));
      _bills[billIndex] = billModel;
      notifyListeners();
    }
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

      if (response.statusCode != 200) {
        // Handle the case where the response body is null (no data returned).
        return;
      }

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<BillModel> loadedBills = [];
      extractedData.forEach((billId, billData) {
        final createdAtString = billData['createdAt'] as String?;
        final duDateString = billData['duDate'] as String?;

        loadedBills.add(BillModel(
          id: billId,
          billName: billData['title'] ?? '',
          billAmount: billData['amount'] ?? 0,
          createdAt: createdAtString != null
              ? DateTime.parse(createdAtString)
              : DateTime.now(),
          description: billData['description'] ?? '',
          dueDate: duDateString != null
              ? DateTime.parse(duDateString)
              : DateTime.now(),
        ));
      });
      _bills = loadedBills;
      notifyListeners();
    } catch (error) {
      // Handle errors appropriately
      print("Error fetching and setting bills: $error");
      rethrow;
    }
  }

  // Future<void> fetchAndSetBills() async {
  //   var url = Uri.parse(
  //       'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills.json');

  //   try {
  //     final response = await http.get(url);

  //     if (response.body == null) {
  //       return;
  //     }
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<BillModel> loadedBills = [];
  //     extractedData.forEach((billId, billData) {
  //       final createdAtString = billData['createdAt'] as String?;
  //       final duDateString = billData['duDate'] as String?;

  //       loadedBills.add(BillModel(
  //         id: billId,
  //         billName: billData['title'] ?? '',
  //         billAmount: billData['amount'] ?? 0,
  //         createdAt: createdAtString != null
  //             ? DateTime.parse(createdAtString)
  //             : DateTime.now(),
  //         description: billData['description'] ?? '',
  //         dueDate: duDateString != null
  //             ? DateTime.parse(duDateString)
  //             : DateTime.now(),
  //       ));
  //     });
  //     _bills = loadedBills;
  //     notifyListeners();
  //   } catch (error) {
  //     // Handle errors appropriately
  //     print("Error fetching and setting bills: $error");
  //     rethrow;
  //   }
  // }

  // Future<void> fetchAndSetBills() async {
  //   var url = Uri.parse(
  //       'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills.json');

  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<BillModel> loadedBills = [];
  //     extractedData.forEach((billId, billData) {
  //       loadedBills.add(BillModel(
  //         id: billId,
  //         billName: billData['title'],
  //         billAmount: billData['amount'],
  //         createdAt: DateTime.parse(billData['createdAt']),
  //         description: billData['description'],
  //         dueDate: DateTime.parse(billData['duDate']),
  //       ));
  //     });
  //     _bills = loadedBills;

  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
