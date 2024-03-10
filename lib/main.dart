import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodshareapp/userselection.dart';
import 'firebase_options.dart';

// hi hello i am amiya
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Donation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            Color.fromARGB(255, 255, 255, 253), // Background color
      ),
      home: UserTypeSelectionPage(),
    );
  }
}
