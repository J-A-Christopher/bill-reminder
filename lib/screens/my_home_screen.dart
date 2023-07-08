import 'package:bill_reminder_app/screens/add_bill_screen.dart';
import 'package:bill_reminder_app/screens/first_page.dart';
import 'package:bill_reminder_app/screens/profile_screen.dart';
import 'package:bill_reminder_app/screens/reminder_screen.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int pageIndex = 0;
  final pages = [
    const FirstScreen(),
    const AddBill(),
    const ReminderScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  )),
              const Expanded(
                  child: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ))
            ],
          ),
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: const Icon(
                    Icons.note_add,
                    color: Colors.white,
                    size: 35,
                  )),
              const Expanded(
                  child: Text(
                'Add Bill',
                style: TextStyle(color: Colors.white),
              ))
            ],
          ),
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: const Icon(
                    Icons.circle_notifications,
                    color: Colors.white,
                    size: 35,
                  )),
              const Expanded(
                  child: Text(
                'Reminders',
                style: TextStyle(color: Colors.white),
              ))
            ],
          ),
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 3;
                    });
                  },
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 35,
                  )),
              const Expanded(
                  child: Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ))
            ],
          ),
        ]),
      ),
    );
  }
}
