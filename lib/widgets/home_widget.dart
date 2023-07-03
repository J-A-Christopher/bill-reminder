import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(style: TextStyle(fontSize: 25), children: [
              TextSpan(text: 'Manage your\n bills & everything\n with'),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'BillBuddy.',
                  style: TextStyle(
                      color: Colors.pink, decoration: TextDecoration.underline))
            ]))
          ],
        ),
      ),
    );
  }
}
