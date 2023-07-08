import 'package:flutter/material.dart';

import '../widgets/home_widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Row(
          children: [
            Icon(Icons.attach_money),
            Text('BillBuddy'),
          ],
        ),
      ),
      body: ListView(
        children: const [HomeWidget()],
      ),
    );
  }
}
