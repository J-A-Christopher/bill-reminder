import 'package:bill_reminder_app/providers/auth_provider.dart';
import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:bill_reminder_app/screens/auth_screen.dart';
import 'package:bill_reminder_app/screens/my_home_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, BillProvider>(
          create: (_) => BillProvider('', [], ''),
          update: (context, auth, previousBills) => BillProvider(auth.token,
              previousBills == null ? [] : previousBills.bills, auth.userId),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, notifier) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData().copyWith(
                  colorScheme: ThemeData().colorScheme.copyWith(
                      secondary: const Color(0xff8e9394),
                      primary: Colors.grey)),
              home: auth.isAuth ? const MyHomeScreen() : const AuthScreen());
        },
      ),
    );
  }
}
