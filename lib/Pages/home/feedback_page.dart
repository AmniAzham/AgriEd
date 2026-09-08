import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  final String formUrl = "https://forms.gle/YOUR_FORM_LINK";

  Future<void> _openForm() async {
    final Uri url = Uri.parse(formUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $formUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 194, 109),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We value your feedback",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Help us improve BERTANI by sharing your experience, suggestions, or reporting any issues.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // 🔥 Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _openForm,
                icon: const Icon(Icons.open_in_new),
                label: const Text("Open Feedback Form"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 255, 194, 109),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}