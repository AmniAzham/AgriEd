import 'package:flutter/material.dart';

class UnitConversionPage extends StatefulWidget {
  const UnitConversionPage({super.key});

  @override
  State<UnitConversionPage> createState() => _UnitConversionPageState();
}

class _UnitConversionPageState extends State<UnitConversionPage> {
  final TextEditingController _inputController = TextEditingController();

  String _selectedCategory = 'Mass';
  String _fromUnit = 'kg';
  String _toUnit = 'g';
  double? _result;

  final Map<String, List<String>> unitCategories = {
    'Mass': ['kg', 'g', 'mg'],
    'Volume': ['L', 'mL'],
    'Area': ['ha', 'm²', 'acre'],
    'Rate': ['kg/ha', 'g/m²'],
  };

  void _resetUnitsForCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _fromUnit = unitCategories[category]!.first;
      _toUnit = unitCategories[category]![1];
      _result = null;
      _inputController.clear();
    });
  }

  double _convertMass(double value, String from, String to) {
    final Map<String, double> toBase = {
      'kg': 1000,
      'g': 1,
      'mg': 0.001,
    };

    final valueInGrams = value * toBase[from]!;
    return valueInGrams / toBase[to]!;
  }

  double _convertVolume(double value, String from, String to) {
    final Map<String, double> toBase = {
      'L': 1000,
      'mL': 1,
    };

    final valueInMl = value * toBase[from]!;
    return valueInMl / toBase[to]!;
  }

  double _convertArea(double value, String from, String to) {
    final Map<String, double> toBase = {
      'ha': 10000,
      'm²': 1,
      'acre': 4046.8564224,
    };

    final valueInM2 = value * toBase[from]!;
    return valueInM2 / toBase[to]!;
  }

  double _convertRate(double value, String from, String to) {
    // 1 kg/ha = 0.1 g/m²
    if (from == 'kg/ha' && to == 'g/m²') {
      return value * 0.1;
    } else if (from == 'g/m²' && to == 'kg/ha') {
      return value * 10;
    }
    return value;
  }

  void _calculateConversion() {
    final double? inputValue = double.tryParse(_inputController.text.trim());

    if (inputValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid number'),
        ),
      );
      return;
    }

    double convertedValue;

    if (_selectedCategory == 'Mass') {
      convertedValue = _convertMass(inputValue, _fromUnit, _toUnit);
    } else if (_selectedCategory == 'Volume') {
      convertedValue = _convertVolume(inputValue, _fromUnit, _toUnit);
    } else if (_selectedCategory == 'Area') {
      convertedValue = _convertArea(inputValue, _fromUnit, _toUnit);
    } else {
      convertedValue = _convertRate(inputValue, _fromUnit, _toUnit);
    }

    setState(() {
      _result = convertedValue;
    });
  }

  void _clearAll() {
    setState(() {
      _inputController.clear();
      _selectedCategory = 'Mass';
      _fromUnit = 'kg';
      _toUnit = 'g';
      _result = null;
    });
  }

  Widget _buildResultCard() {
    if (_result == null) return const SizedBox.shrink();

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
            'Conversion Result',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${_inputController.text} $_fromUnit = ${_result!.toStringAsFixed(4)} $_toUnit',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUnits = unitCategories[_selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Conversion'),
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
              'Convert common agricultural units used in fertilizer calculations.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Select Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: unitCategories.keys.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _resetUnitsForCategory(value);
                }
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Input Value',
                hintText: 'Enter value',
                prefixIcon: const Icon(Icons.swap_horiz),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'From Unit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _fromUnit,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: currentUnits.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _fromUnit = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'To Unit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _toUnit,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: currentUnits.map((unit) {
                return DropdownMenuItem(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _toUnit = value;
                  });
                }
              },
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateConversion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(199, 156, 255, 156),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Convert',
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