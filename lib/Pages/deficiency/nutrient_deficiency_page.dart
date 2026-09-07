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

class _NutrientDeficiencyPageState
    extends State<NutrientDeficiencyPage> {
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
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();

        isLoading = false;
      });
    } catch (error) {
      debugPrint(
        'Error loading nutrient deficiencies: $error',
      );

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
            builder: (_) =>
                NutrientDeficiencyDetailPage(
              title: item["title"] as String,
              images: List<String>.from(
                item["images"] as List,
              ),
              content: item["content"] as String,
            ),
          ),
        );
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 122, 157, 255),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 130,
              height: double.infinity,
              child: Image.asset(
                item["coverImage"] as String,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  18,
                  16,
                  18,
                  16,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item["subtitle"] as String,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "View symptoms",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
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
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title:
              const Text("Nutrient Deficiency"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrient Deficiency"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: deficiencies.isEmpty
          ? const Center(
              child: Text(
                "No nutrient deficiency data found.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: deficiencies.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item =
                    deficiencies[index];

                return _buildDeficiencyCard(
                  context,
                  item,
                );
              },
            ),
    );
  }
}