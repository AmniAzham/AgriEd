import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'area_calculator_page.dart';
import 'unit_conversion_calculator_page.dart';
import 'nutrient_fertilizer_calculator.dart';
import 'npk_conversion_calculator.dart';
import 'total_fertilizer_needed_calculator.dart';
import 'split_application_calculator.dart';
import 'per_plant_fertilizer_calculator.dart';
import 'cost_calculator_page.dart';
import '../home/saved_items_service.dart';

class FertilizerPage extends StatelessWidget {
  const FertilizerPage({super.key});

  static const List<Map<String, dynamic>> calculators = [
    {
      "title": "Area Calculator",
      "id": "fert_calc_area",
      "section": "Fertilizer Calculators",
      "subtitle": "Measure land size",
      "routeType": "calculator",
      "index": 0,
      "image": "assets/images/calculator/area.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "Unit Conversion",
      "id": "fert_calc_unit_conversion",
      "section": "Fertilizer Calculators",
      "subtitle": "Convert units",
      "routeType": "calculator",
      "index": 1,
      "image": "assets/images/calculator/conversion.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "Nutrient → Fertilizer",
      "id": "fert_calc_nutrient_to_fertilizer",
      "section": "Fertilizer Calculators",
      "subtitle": "Convert NPK to product",
      "routeType": "calculator",
      "index": 2,
      "image": "assets/images/calculator/nutrient.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "NPK Conversion",
      "id": "fert_calc_npk_conversion",
      "section": "Fertilizer Calculators",
      "subtitle": "Convert P₂O₅, K₂O",
      "routeType": "calculator",
      "index": 3,
      "image": "assets/images/calculator/npk.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "Total Fertilizer Needed",
      "id": "fert_calc_total_fertilizer_needed",
      "section": "Fertilizer Calculators",
      "subtitle": "Field total amount",
      "routeType": "calculator",
      "index": 4,
      "image": "assets/images/calculator/total.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "Split Application",
      "id": "fert_calc_split_application",
      "section": "Fertilizer Calculators",
      "subtitle": "Divide application stages",
      "routeType": "calculator",
      "index": 5,
      "image": "assets/images/calculator/split.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "Per Plant Fertilizer",
      "id": "fert_calc_per_plant_fertilizer",
      "section": "Fertilizer Calculators",
      "subtitle": "Rate per plant",
      "routeType": "calculator",
      "index": 6,
      "image": "assets/images/calculator/plant.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
    {
      "title": "Cost Calculator",
      "id": "fert_calc_cost_calculator",
      "section": "Fertilizer Calculators",
      "subtitle": "Estimate fertilizer cost",
      "routeType": "calculator",
      "index": 7,
      "image": "assets/images/calculator/cost.png",
      "color": Color.fromARGB(255, 17, 192, 46),
    },
  ];

  void _handleCalculatorTap(BuildContext context, int index) {
    final pages = [
      const AreaCalculatorPage(),
      const UnitConversionPage(),
      const NutrientFertilizerCalculatorPage(),
      const NpkConversionCalculatorPage(),
      const TotalFertilizerNeededCalculatorPage(),
      const SplitApplicationCalculatorPage(),
      const PerPlantFertilizerCalculatorPage(),
      const CostCalculatorPage(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => pages[index],
      ),
    );
  }

  Widget _buildCalculatorCard(
    BuildContext context,
    Map<String, dynamic> item,
    int index,
  ) {
    final savedService = Provider.of<SavedItemsService>(context);
    final isSaved = savedService.isSaved(item["id"] as String);

    return GestureDetector(
      onTap: () => _handleCalculatorTap(context, index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: item["color"] as Color,
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    item["image"] as String,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  right: 14,
                  child: Text(
                    item["title"] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: -8,
            right: -8,
            child: GestureDetector(
              onTap: () async {
                final wasSaved = savedService.isSaved(item["id"] as String);

                final savedItem = {
                  "id": item["id"],
                  "title": item["title"],
                  "subtitle": item["subtitle"],
                  "section": item["section"],
                  "routeType": item["routeType"],
                  "index": item["index"],
                };

                await savedService.toggleSaved(savedItem);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        wasSaved ? 'Removed from Saved' : 'Saved successfully',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved ? Colors.green : Colors.black87,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertilizer Calculators"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: calculators.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 17,
            mainAxisSpacing: 17,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final item = calculators[index];
            return _buildCalculatorCard(context, item, index);
          },
        ),
      ),
    );
  }
}