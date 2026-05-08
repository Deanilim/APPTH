import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'services/firebase_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase no está configurado todavía: $e');
  }

  runApp(const AppTHApp());
}

class AppTHApp extends StatelessWidget {
  const AppTHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FirebaseService()..initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APPTH',
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 90))
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(duration: 900.ms, begin: const Offset(1, 1), end: const Offset(1.18, 1.18)),
            const SizedBox(height: 14),
            const Text(
              'APPTH',
              style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aprender español es divertido',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
