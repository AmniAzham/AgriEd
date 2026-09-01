import 'dart:async';
import 'package:flutter/material.dart';
import 'main_shell_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainShellPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.eco_rounded,
              size: 90,
              color: Color.fromARGB(255, 7, 153, 29),
            ),
            SizedBox(height: 20),
            Text(
              "AgriEd",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 0, 205, 92),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Smart Agriculture Learning",
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(179, 0, 234, 125),
              ),
            ),
          ],
        ),
      ),
    );
  }
}