import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fertilizer_reference_detail_page.dart';

class FertilizerReferencePage extends StatefulWidget {
  const FertilizerReferencePage({super.key});

  @override
  State<FertilizerReferencePage> createState() =>
      _FertilizerReferencePageState();
}

class _FertilizerReferencePageState
    extends State<FertilizerReferencePage> {
  List<Map<String, dynamic>> fertilizers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFertilizers();
  }

  Future<void> _loadFertilizers() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/fertilizer_reference.json',
      );

      final List<dynamic> data = jsonDecode(response);

      if (!mounted) return;

      setState(() {
        fertilizers = data
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();

        isLoading = false;
      });
    } catch (error) {
      debugPrint(
        'Error loading fertilizer reference: $error',
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildFertilizerCard(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FertilizerReferenceDetailPage(
              title: item["title"] as String,
              images: List<String>.from(
                item["images"] as List,
              ),
              sections: List<Map<String, dynamic>>.from(
                (item["sections"] as List).map(
                  (section) =>
                      Map<String, dynamic>.from(section),
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color.fromARGB(
            255,
            255,
            55,
            172,
          ),
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
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item["subtitle"] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    const Row(
                      children: [
                        Icon(
                          Icons.library_books_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "View reference",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
          title: const Text(
            "Fertilizer Reference",
          ),
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
        title: const Text(
          "Fertilizer Reference",
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: fertilizers.isEmpty
          ? const Center(
              child: Text(
                "No fertilizer reference data found.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: fertilizers.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final item = fertilizers[index];

                return _buildFertilizerCard(
                  context,
                  item,
                );
              },
            ),
    );
  }
}