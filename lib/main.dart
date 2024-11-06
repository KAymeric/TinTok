import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tintok/home.dart';
import 'package:tintok/login.dart';
import 'package:tintok/profile.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hijxlndjnvivbwilxvdl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhpanhsbmRqbnZpdmJ3aWx4dmRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA3OTQ2ODgsImV4cCI6MjA0NjM3MDY4OH0.sIeMFL2taQ8Lp3x4kEhs6HBIwoaGLaIBEiqGJYurcpA',
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/login': (context) => Login(),
      }
    );
  }
}
