import 'package:flutter/material.dart';

class NutrientFertilizerCalculatorPage extends StatefulWidget {
  const NutrientFertilizerCalculatorPage({super.key});

  @override
  State<NutrientFertilizerCalculatorPage> createState() =>
      _NutrientFertilizerCalculatorPageState();
}

class _NutrientFertilizerCalculatorPageState
    extends State<NutrientFertilizerCalculatorPage> {
  final TextEditingController _nutrientController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();

  String _selectedNutrient = 'Nitrogen (N)';
  double? _result;

  final Map<String, double> fertilizerPresets = {
    'Urea (46% N)': 46,
    'Ammonium Sulfate (21% N)': 21,
    'TSP (46% P₂O₅)': 46,
    'MOP (60% K₂O)': 60,
    'NPK 15-15-15': 15,
  };

  void _applyPreset(String fertilizer) {
    setState(() {
      _percentageController.text =
          fertilizerPresets[fertilizer]!.toString();
    });
  }

  void _calculate() {
    final double? nutrient =
        double.tryParse(_nutrientController.text.trim());
    final double? percentage =
        double.tryParse(_percentageController.text.trim());

    if (nutrient == null || nutrient <= 0) {
      _showError('Enter valid nutrient requirement');
      return;
    }

    if (percentage == null || percentage <= 0 || percentage > 100) {
      _showError('Enter valid fertilizer percentage');
      return;
    }

    final result = nutrient / (percentage / 100);

    setState(() {
      _result = result;
    });
  }

  void _clear() {
    setState(() {
      _nutrientController.clear();
      _percentageController.clear();
      _result = null;
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _buildResult() {
    if (_result == null) return const SizedBox();

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
            'Result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Fertilizer needed = ${_result!.toStringAsFixed(2)} kg/ha',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nutrientController.dispose();
    _percentageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrient → Fertilizer'),
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
              'Convert nutrient requirement into fertilizer amount.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Nutrient type
            const Text(
              'Select Nutrient',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _selectedNutrient,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'Nitrogen (N)', child: Text('Nitrogen (N)')),
                DropdownMenuItem(
                    value: 'Phosphorus (P₂O₅)',
                    child: Text('Phosphorus (P₂O₅)')),
                DropdownMenuItem(
                    value: 'Potassium (K₂O)',
                    child: Text('Potassium (K₂O)')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedNutrient = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            // Nutrient required
            TextField(
              controller: _nutrientController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Nutrient required (kg/ha)',
                prefixIcon: const Icon(Icons.eco),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Fertilizer %
            TextField(
              controller: _percentageController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Fertilizer nutrient (%)',
                prefixIcon: const Icon(Icons.percent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Quick Select Fertilizer',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: fertilizerPresets.keys.map((fert) {
                return ActionChip(
                  label: Text(fert),
                  onPressed: () => _applyPreset(fert),
                );
              }).toList(),
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
                    ),
                    child: const Text('Calculate'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clear,
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            _buildResult(),
          ],
        ),
      ),
    );
  }
}