import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'saved_items_service.dart';

import '../calculator/area_calculator_page.dart';
import '../calculator/unit_conversion_calculator_page.dart';
import '../calculator/nutrient_fertilizer_calculator.dart';
import '../calculator/npk_conversion_calculator.dart';
import '../calculator/total_fertilizer_needed_calculator.dart';
import '../calculator/split_application_calculator.dart';
import '../calculator/per_plant_fertilizer_calculator.dart';
import '../calculator/cost_calculator_page.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

void _openSavedItem(BuildContext context, Map<String, dynamic> item) {
  final routeType = item['routeType'];
  final index = item['index'];

  if (routeType == 'calculator') {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Page not found')),
        );
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('This saved item is not linked yet')),
  );

  
}



  @override
  Widget build(BuildContext context) {
    final savedService = Provider.of<SavedItemsService>(context);
    final items = savedService.savedItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'No saved items yet.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
itemBuilder: (context, index) {
  final item = items[index];

  return GestureDetector(
    onTap: () => _openSavedItem(context, item),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.bookmark, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                 item['subtitle'] ?? '',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  item['section'] ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => savedService.toggleSaved(item),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    ),
  );
}
            ),
    );
  }
}