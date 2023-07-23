import 'package:bill_reminder_app/providers/auth_provider.dart';
import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:bill_reminder_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(
          create: (context) => BillProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                  secondary: const Color(0xff8e9394), primary: Colors.grey)),
          home: const AuthScreen()
          // const MyHomeScreen()
          ),
    );
  }
}
