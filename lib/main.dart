import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'app.dart';
import 'package:url_launcher/url_launcher.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/resume') {
          launchUrl(Uri.base.resolve('/resume/resumeV1.pdf'));
        }
        return MaterialPageRoute(builder: (_) => const PortfolioApp());
      },
    );
  }
}
