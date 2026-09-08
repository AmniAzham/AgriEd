import 'package:flutter/material.dart';

// CALCULATORS
import '../calculator/area_calculator_page.dart';
import '../calculator/unit_conversion_calculator_page.dart';
import '../calculator/nutrient_fertilizer_calculator.dart';
import '../calculator/npk_conversion_calculator.dart';
import '../calculator/total_fertilizer_needed_calculator.dart';
import '../calculator/split_application_calculator.dart';
import '../calculator/per_plant_fertilizer_calculator.dart';
import '../calculator/cost_calculator_page.dart';

// OTHER SECTIONS
import '../agronomy/agronomy_notes_page.dart';
import '../deficiency/nutrient_deficiency_page.dart';
import '../reference/fertilizer_reference_page.dart';

// MORE
import 'feedback_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> calculators = [
    {"title": "Area", "image": "assets/images/calculator/area.png"},
    {
      "title": "Unit Conversion",
      "image": "assets/images/calculator/conversion.png",
    },
    {
      "title": "Nutrient → Fertilizer",
      "image": "assets/images/calculator/nutrient.png",
    },
    {"title": "NPK Conversion", "image": "assets/images/calculator/npk.png"},
    {
      "title": "Total Fertilizer",
      "image": "assets/images/calculator/total.png",
    },
    {
      "title": "Split Application",
      "image": "assets/images/calculator/split.png",
    },
    {
      "title": "Per Plant Fertilizer",
      "image": "assets/images/calculator/plant.png",
    },
    {"title": "Cost", "image": "assets/images/calculator/cost.png"},
  ];

  static const List<Map<String, String>> others = [
    {"title": "Agronomy Notes", "image": "assets/images/main/agronomy.png"},
    {
      "title": "Nutrient Deficiency",
      "image": "assets/images/main/deficiency.png",
    },
    {
      "title": "Fertilizer Reference",
      "image": "assets/images/main/reference.png",
    },
  ];

  void _openCalculator(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const AreaCalculatorPage();
        break;
      case 1:
        page = const UnitConversionPage();
        break;
      case 2:
        page = const NutrientFertilizerCalculatorPage();
        break;
      case 3:
        page = const NpkConversionCalculatorPage();
        break;
      case 4:
        page = const TotalFertilizerNeededCalculatorPage();
        break;
      case 5:
        page = const SplitApplicationCalculatorPage();
        break;
      case 6:
        page = const PerPlantFertilizerCalculatorPage();
        break;
      case 7:
        page = const CostCalculatorPage();
        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  void _openOther(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page = const AgronomyNotesPage();
        break;
      case 1:
        page = const NutrientDeficiencyPage();
        break;
      case 2:
        page = const FertilizerReferencePage();
        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _buildCircleButton({
    required String title,
    required String image,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x18000000),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(child: Image.asset(image, fit: BoxFit.cover)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                height: 1.15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 14),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FeedbackPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 194, 109),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(
          children: [
            Icon(Icons.feedback_outlined, color: Colors.white, size: 34),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Feedback",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Share your comments and suggestions",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "AgriEd",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 27, 140, 93),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.language),
            color: const Color.fromARGB(255, 27, 140, 93),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              "What brings you to AgriEd?",
              style: TextStyle(fontSize: 17, color: Colors.black54),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // FERTILIZER CALCULATORS
            // ==================================================
            _buildSectionTitle("Fertilizer Calculators"),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: calculators.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 14,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final item = calculators[index];

                return _buildCircleButton(
                  title: item["title"]!,
                  image: item["image"]!,
                  onTap: () => _openCalculator(context, index),
                );
              },
            ),

            const SizedBox(height: 26),
            // ==================================================
            // OTHERS
            // ==================================================
            _buildSectionTitle("Others"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(others.length, (index) {
                final item = others[index];

                return Expanded(
                  child: _buildCircleButton(
                    title: item["title"]!,
                    image: item["image"]!,
                    onTap: () => _openOther(context, index),
                  ),
                );
              }),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // MORE
            // ==================================================
            _buildSectionTitle("More"),

            _buildFeedbackCard(context),
          ],
        ),
      ),
    );
  }
}
