import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 194, 109),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text(
              "AgriEd",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "A smart agriculture learning app designed to support students and future agripreneurs in understanding fertilizer management and crop nutrition.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            SizedBox(height: 20),

            Text(
              "Purpose",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "To make agriculture learning more interactive, practical, and accessible through mobile technology.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 16),

            Text(
              "Key Features",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "- Fertilizer Calculators\n"
              "- Agronomy Notes\n"
              "- Nutrient Deficiency Guide\n"
              "- Fertilizer Reference",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 16),

            Text(
              "Developed For",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Agriculture students and educators as a teaching innovation tool.",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}