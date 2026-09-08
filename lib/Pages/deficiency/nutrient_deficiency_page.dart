import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'nutrient_deficiency_detail_page.dart';

class NutrientDeficiencyPage extends StatefulWidget {
  const NutrientDeficiencyPage({super.key});

  @override
  State<NutrientDeficiencyPage> createState() =>
      _NutrientDeficiencyPageState();
}

class _NutrientDeficiencyPageState extends State<NutrientDeficiencyPage> {
  List<Map<String, dynamic>> deficiencies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDeficiencies();
  }

  Future<void> _loadDeficiencies() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/nutrient_deficiency.json',
      );

      final List<dynamic> data = jsonDecode(response);

      if (!mounted) return;

      setState(() {
        deficiencies = data
            .map((item) => Map<String, dynamic>.from(item))
            .toList();

        isLoading = false;
      });
    } catch (error) {
      debugPrint('Error loading nutrient deficiencies: $error');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildDeficiencyCard(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NutrientDeficiencyDetailPage(
              title: item["title"] as String,
              images: List<String>.from(item["images"] as List),
              content: item["content"] as String,
            ),
          ),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 122, 157, 255),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  item["coverImage"] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // TEXT
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Expanded(
                      child: Text(
                        item["subtitle"] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.2,
                          color: Colors.white70,
                        ),
                      ),
                    ),

                    const Text(
                      "View symptoms",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrient Deficiency"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : deficiencies.isEmpty
              ? const Center(
                  child: Text(
                    "No nutrient deficiency data found.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(14),

                  itemCount: deficiencies.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    // TWO CARDS PER ROW
                    crossAxisCount: 2,

                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,

                    // Controls card height
                    childAspectRatio: 0.82,
                  ),

                  itemBuilder: (context, index) {
                    final item = deficiencies[index];

                    return _buildDeficiencyCard(
                      context,
                      item,
                    );
                  },
                ),
    );
  }
}