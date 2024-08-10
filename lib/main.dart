import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:length_conversion/conversion_history.dart';

import 'conversionscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ConversionHistoryAdapter().typeId)) {
    Hive.registerAdapter(ConversionHistoryAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.lightBlue,
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey)),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 185, 157),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LENGTH CONVERTER',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 67, 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return ConversionScreen();
                }));
              },
              style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 24, 109, 27),
                  backgroundColor: Color.fromARGB(255, 196, 237, 198)),
              child: Text('START'),
            ),
          ],
        ),
      ),
    );
  }
}
