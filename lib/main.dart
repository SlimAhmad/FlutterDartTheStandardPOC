import 'package:flutter/material.dart';
import 'package:hello_world/pages/first_page.dart';
import 'package:hello_world/pages/home_page.dart';
import 'package:hello_world/pages/profile_page.dart';
import 'package:hello_world/pages/settings_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      routes: {
         '/firstpage': (context) => const FirstPage(),
         '/home': (context) => const HomePage(),
         '/settings': (context) => const SettingsPage(),
         '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
