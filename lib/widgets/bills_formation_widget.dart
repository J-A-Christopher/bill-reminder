import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillCreation extends StatefulWidget {
  const BillCreation({super.key});

  @override
  State<BillCreation> createState() => _BillCreationState();
}

class _BillCreationState extends State<BillCreation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BillProvider>(builder: ((context, value, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.green,
              child: Icon(Icons.monetization_on_sharp),
            ),
            title: Text(value.bills[index].description),
          );
        },
        itemCount: value.bills.length,
      );
    }));
  }
}
