import 'package:flutter/material.dart';
import 'fertilizer_reference_detail_page.dart';

class FertilizerReferencePage extends StatelessWidget {
  const FertilizerReferencePage({super.key});

  static const List<Map<String, dynamic>> fertilizers = [
    {
      "title": "Urea",
      "subtitle": "High nitrogen fertilizer",
      "coverImage": "assets/images/reference/fertilizer1.png",
      "images": [
        "assets/images/reference/fertilizer1.png",
        "assets/images/reference/fertilizer2.png",
      ],
      "sections": [
        {"heading": "Type", "text": "Nitrogen fertilizer."},
        {"heading": "Nutrient Content", "text": "46% N"},
        {"heading": "Function", "text": "Supports vegetative growth."},
        {"heading": "Suitable Crops", "text": "Maize, rice, leafy vegetables and many other crops."},
        {"heading": "Application Method", "text": "Apply according to crop requirement."},
        {"heading": "Notes", "text": "Avoid losses through volatilization."},
      ],
    },
    {
      "title": "NPK 15:15:15",
      "subtitle": "Balanced compound fertilizer",
      "coverImage": "assets/images/reference/fertilizer2.png",
      "images": [
        "assets/images/reference/fertilizer2.png",
        "assets/images/reference/fertilizer3.png",
      ],
      "sections": [
        {"heading": "Type", "text": "Compound fertilizer."},
        {"heading": "Nutrient Content", "text": "15% N, 15% P₂O₅, 15% K₂O"},
        {"heading": "Function", "text": "General balanced nutrition."},
        {"heading": "Application Method", "text": "Basal or top dressing depending on crop."},
        {"heading": "Notes", "text": "Useful as general purpose fertilizer."},
      ],
    },
    {
      "title": "TSP",
      "subtitle": "Phosphorus source",
      "coverImage": "assets/images/reference/fertilizer3.png",
      "images": [
        "assets/images/reference/fertilizer3.png",
        "assets/images/reference/fertilizer1.png",
      ],
      "sections": [
        {"heading": "Type", "text": "Phosphorus fertilizer."},
        {"heading": "Nutrient Content", "text": "46% P₂O₅"},
        {"heading": "Function", "text": "Supports root development."},
        {"heading": "Application Method", "text": "Often applied as basal fertilizer."},
        {"heading": "Notes", "text": "Best incorporated into soil."},
      ],
    },
  ];

  Widget _buildFertilizerCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FertilizerReferenceDetailPage(
              title: item["title"] as String,
              images: List<String>.from(item["images"] as List),
              sections: List<Map<String, dynamic>>.from(item["sections"] as List),
            ),
          ),
        );
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 55, 172),
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
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(Icons.library_books_rounded, color: Colors.white, size: 20),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertilizer Reference"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: fertilizers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final item = fertilizers[index];
          return _buildFertilizerCard(context, item);
        },
      ),
    );
  }
}