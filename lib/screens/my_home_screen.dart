import 'package:bill_reminder_app/widgets/home_widget.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          title: const Row(
            children: [
              Icon(Icons.attach_money),
              Text('BillBuddy'),
            ],
          ),
        ),
        body: ListView(
          children: const [HomeWidget()],
        )
        // const SingleChildScrollView(
        //   child: SizedBox(
        //     height: 1000,
        //     child: Column(
        //       children: [HomeWidget()],
        //     ),
        //   ),
        // ),
        );
  }
}
