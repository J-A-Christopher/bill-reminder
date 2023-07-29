import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/home_widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content:
                            const Text('Are you sure, do you want to logout?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Provider.of<Auth>(context, listen: false)
                                    .logOut();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.exit_to_app))
        ],
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
