import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> appValues = [
      'Organise Your Bills',
      'Set Reminders',
      'Automatic Notifications',
      'Secure and Private',
      'Cross PlatForm Access'
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text.rich(TextSpan(style: TextStyle(fontSize: 25), children: [
            TextSpan(text: 'Manage your\n bills & everything\n with'),
            TextSpan(text: ' '),
            TextSpan(
                text: 'BillBuddy.',
                style: TextStyle(
                    color: Colors.pink, decoration: TextDecoration.underline))
          ])),
          SvgPicture.asset(
            'assets/pic.svg',
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const SizedBox(
            height: 10,
          ),
          const Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'We understand that keeping track of your bills can be a daunting task. Which is why we are happy to make your life easier. This app will help you stay on top of your finances effortlessly. With our powerful fetures and intuitive interface, managing your bills has never been simpler.',
                style: TextStyle(height: 1.5, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
              'Some of the features you\'ll enjoy are highlighted below:'),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  children: appValues.map((value) {
                return Row(
                  children: [
                    const Text(
                      "\u2022",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      value,
                      style: const TextStyle(fontSize: 15),
                    ))
                  ],
                );
              }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
