import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gayathry Rajeev — Data Analyst Portfolio',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const PortfolioApp(),
    );
  }
}
