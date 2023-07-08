import 'package:flutter/cupertino.dart';

import '../Data/models/bill_model.dart';

class BillProvider extends ChangeNotifier {
  final List<BillModel> _bills = [];

  List<BillModel> get bills {
    return [..._bills];
  }
}
