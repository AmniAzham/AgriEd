import 'package:flutter/material.dart';
import 'nutrient_deficiency_detail_page.dart';

class NutrientDeficiencyPage extends StatelessWidget {
  const NutrientDeficiencyPage({super.key});

  static const List<Map<String, dynamic>> deficiencies = [
    {
      "title": "Nitrogen (N)",
      "subtitle": "Yellowing of older leaves",
      "coverImage": "assets/images/deficiency/deficiency1.png",
      "images": [
        "assets/images/deficiency/deficiency1.png",
        "assets/images/deficiency/deficiency2.png",
      ],
      "content":
          "Overview\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit.\n\n"
          "Symptoms\n\nYellowing of older leaves.\n\n"
          "Where it appears\n\nUsually older leaves first.\n\n"
          "Cause\n\nLorem ipsum dolor sit amet.\n\n"
          "Solution\n\nApply suitable nitrogen fertilizer such as urea.",
    },
    {
      "title": "Phosphorus (P)",
      "subtitle": "Purpling and poor root growth",
      "coverImage": "assets/images/deficiency/deficiency2.png",
      "images": [
        "assets/images/deficiency/deficiency2.png",
        "assets/images/deficiency/deficiency3.png",
      ],
      "content":
          "Overview\n\nLorem ipsum dolor sit amet.\n\n"
          "Symptoms\n\nPurpling, stunted growth, weak roots.\n\n"
          "Where it appears\n\nOlder leaves first.\n\n"
          "Cause\n\nLorem ipsum dolor sit amet.\n\n"
          "Solution\n\nApply phosphorus fertilizer such as TSP.",
    },
    {
      "title": "Potassium (K)",
      "subtitle": "Leaf edge scorch and weak plants",
      "coverImage": "assets/images/deficiency/deficiency3.png",
      "images": [
        "assets/images/deficiency/deficiency3.png",
        "assets/images/deficiency/deficiency1.png",
      ],
      "content":
          "Overview\n\nLorem ipsum dolor sit amet.\n\n"
          "Symptoms\n\nLeaf margins burn and curl.\n\n"
          "Where it appears\n\nOlder leaves first.\n\n"
          "Cause\n\nLorem ipsum dolor sit amet.\n\n"
          "Solution\n\nApply potassium fertilizer such as MOP.",
    },
    {
      "title": "Magnesium (Mg)",
      "subtitle": "Interveinal chlorosis on older leaves",
      "coverImage": "assets/images/deficiency/deficiency1.png",
      "images": [
        "assets/images/deficiency/deficiency1.png",
        "assets/images/deficiency/deficiency3.png",
      ],
      "content":
          "Overview\n\nLorem ipsum dolor sit amet.\n\n"
          "Symptoms\n\nInterveinal chlorosis on older leaves.\n\n"
          "Where it appears\n\nOlder leaves first.\n\n"
          "Cause\n\nLorem ipsum dolor sit amet.\n\n"
          "Solution\n\nApply kieserite or magnesium source.",
    },
    {
      "title": "Calcium (Ca)",
      "subtitle": "New leaves distorted",
      "coverImage": "assets/images/deficiency/deficiency2.png",
      "images": [
        "assets/images/deficiency/deficiency2.png",
        "assets/images/deficiency/deficiency1.png",
      ],
      "content":
          "Overview\n\nLorem ipsum dolor sit amet.\n\n"
          "Symptoms\n\nNew leaves deformed, tip burn.\n\n"
          "Where it appears\n\nYoung leaves first.\n\n"
          "Cause\n\nLorem ipsum dolor sit amet.\n\n"
          "Solution\n\nApply calcium fertilizer or lime source.",
    },
  ];

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
      height: 140,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 94, 88, 255),
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
                      fontSize: 18,
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
                      
                      SizedBox(width: 6),
                      Text(
                        "View symptoms",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
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
        title: const Text("Nutrient Deficiency"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: deficiencies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final item = deficiencies[index];
          return _buildDeficiencyCard(context, item);
        },
      ),
    );
  }
}