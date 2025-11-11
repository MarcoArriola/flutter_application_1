import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FuelBarApp());
}

class FuelBarApp extends StatelessWidget {
  const FuelBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FuelBar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
