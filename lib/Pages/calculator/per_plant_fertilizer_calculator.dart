import 'package:flutter/material.dart';

class PerPlantFertilizerCalculatorPage extends StatefulWidget {
  const PerPlantFertilizerCalculatorPage({super.key});

  @override
  State<PerPlantFertilizerCalculatorPage> createState() =>
      _PerPlantFertilizerCalculatorPageState();
}

class _PerPlantFertilizerCalculatorPageState
    extends State<PerPlantFertilizerCalculatorPage> {
  final TextEditingController _fertilizerRateController =
      TextEditingController();
  final TextEditingController _rowSpacingController = TextEditingController();
  final TextEditingController _plantSpacingController = TextEditingController();

  String _spacingUnit = 'm';

  double? _plantsPerHa;
  double? _fertilizerPerPlantKg;
  double? _fertilizerPerPlantG;

  void _calculate() {
    final double? fertilizerRate =
        double.tryParse(_fertilizerRateController.text.trim());
    final double? rowSpacing =
        double.tryParse(_rowSpacingController.text.trim());
    final double? plantSpacing =
        double.tryParse(_plantSpacingController.text.trim());

    if (fertilizerRate == null || fertilizerRate <= 0) {
      _showError('Please enter a valid fertilizer rate (kg/ha).');
      return;
    }

    if (rowSpacing == null || rowSpacing <= 0) {
      _showError('Please enter a valid row spacing.');
      return;
    }

    if (plantSpacing == null || plantSpacing <= 0) {
      _showError('Please enter a valid plant spacing.');
      return;
    }

    double rowSpacingM = rowSpacing;
    double plantSpacingM = plantSpacing;

    if (_spacingUnit == 'cm') {
      rowSpacingM = rowSpacing / 100;
      plantSpacingM = plantSpacing / 100;
    }

    final double areaPerPlant = rowSpacingM * plantSpacingM;
    final double plantsPerHa = 10000 / areaPerPlant;
    final double fertilizerPerPlantKg = fertilizerRate / plantsPerHa;
    final double fertilizerPerPlantG = fertilizerPerPlantKg * 1000;

    setState(() {
      _plantsPerHa = plantsPerHa;
      _fertilizerPerPlantKg = fertilizerPerPlantKg;
      _fertilizerPerPlantG = fertilizerPerPlantG;
    });
  }

  void _clearAll() {
    setState(() {
      _fertilizerRateController.clear();
      _rowSpacingController.clear();
      _plantSpacingController.clear();
      _spacingUnit = 'm';
      _plantsPerHa = null;
      _fertilizerPerPlantKg = null;
      _fertilizerPerPlantG = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildResultCard() {
    if (_plantsPerHa == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Calculation Result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Plants per hectare = ${_plantsPerHa!.toStringAsFixed(0)} plants',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Fertilizer per plant = ${_fertilizerPerPlantKg!.toStringAsFixed(4)} kg/plant',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Fertilizer per plant = ${_fertilizerPerPlantG!.toStringAsFixed(2)} g/plant',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fertilizerRateController.dispose();
    _rowSpacingController.dispose();
    _plantSpacingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Per Plant Fertilizer'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Convert fertilizer recommendation from kg/ha into amount per plant.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _fertilizerRateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Fertilizer rate (kg/ha)',
                hintText: 'Enter fertilizer rate',
                prefixIcon: const Icon(Icons.eco),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _rowSpacingController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Row spacing',
                hintText: 'Enter row spacing',
                prefixIcon: const Icon(Icons.straighten),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _plantSpacingController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Plant spacing',
                hintText: 'Enter plant spacing',
                prefixIcon: const Icon(Icons.straighten),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Spacing Unit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _spacingUnit,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'm',
                  child: Text('Meter (m)'),
                ),
                DropdownMenuItem(
                  value: 'cm',
                  child: Text('Centimeter (cm)'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _spacingUnit = value;
                  });
                }
              },
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(199, 156, 255, 156),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Calculate',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clearAll,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }
}