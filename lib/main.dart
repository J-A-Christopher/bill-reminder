import 'package:bill_reminder_app/providers/auth_provider.dart';
import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:bill_reminder_app/screens/auth_screen.dart';
import 'package:bill_reminder_app/screens/my_home_screen.dart';
import 'package:bill_reminder_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await FirebaseApi().initNotifications();
//   runApp(const MyApp());
// final messaging = FirebaseMessaging.instance;
// final settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true);
// if (kDebugMode) {
//   print('Permission granted: ${settings.authorizationStatus}');
// }

// String? token = await messaging.getToken();
// if (kDebugMode) {
//   print('Registration Token=$token');
// }
// }
//diiETVwsRNy_aMeGrYBZLs:APA91bFvtt3wq8g6AasshsVZjRomOZh5lWqtWYtrgwPpwgARL03hpH8AbU0L6AUfvUfEAfk2Rc1Ie5janwYch6EtwRNMBER0RArQDMeaIHLFkgd_N4IiBBoS5EGHFBu-9oXRg30inpgr

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
              home: auth.isAuth
                  ? const MyHomeScreen()
                  : FutureBuilder(
                      future: auth.autoLogin(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen();
                      }));
        },
      ),
    );
  }
}
