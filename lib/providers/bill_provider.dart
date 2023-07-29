import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../Data/models/bill_model.dart';
import 'package:http/http.dart' as http;

class BillProvider extends ChangeNotifier {
  final String? authToken;
  final String? userId;
  BillProvider(this.authToken, this._bills, this.userId);

  List<BillModel> _bills = [];

  List<BillModel> get bills {
    return [..._bills];
  }

  Future<void> updateProduct(String id, BillModel billModel) async {
    final billIndex = _bills.indexWhere((bill) => bill.id == id);
    try {
      if (billIndex >= 0) {
        var url = Uri.parse(
            'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills/$id.json?auth=$authToken');
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
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addBill(BillModel bill) async {
    var url = Uri.parse(
        'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': bill.billName,
            'description': bill.description,
            'amount': bill.billAmount,
            'duDate': bill.dueDate?.toIso8601String(),
            'createdAt': bill.createdAt?.toIso8601String(),
            'userId': userId
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

  Future<void> deleteBill(String id) async {
    var url = Uri.parse(
        'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills/$id.json?auth=$authToken');
    final existingBillIndex = _bills.indexWhere((bill) => bill.id == id);
    BillModel? existingBill = _bills[existingBillIndex];
    _bills.removeAt(existingBillIndex);
    notifyListeners();

    _bills.removeWhere((bill) => bill.id == id);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _bills.insert(existingBillIndex, existingBill);
      notifyListeners();
      throw const HttpException('Could not delete Bill');
    }
    existingBill = null;

    notifyListeners();
  }

  Future<void> fetchAndSetBills() async {
    var url = Uri.parse(
        'https://bill-reminder-7ceee-default-rtdb.firebaseio.com/bills.json?auth=$authToken&orderBy="userId"&equalTo="$userId"');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
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
      print("Error fetching and setting bills: $error");
      rethrow;
    }
  }
}
