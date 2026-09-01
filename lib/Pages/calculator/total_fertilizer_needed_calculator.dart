import 'package:flutter/material.dart';

class TotalFertilizerNeededCalculatorPage extends StatefulWidget {
  const TotalFertilizerNeededCalculatorPage({super.key});

  @override
  State<TotalFertilizerNeededCalculatorPage> createState() =>
      _TotalFertilizerNeededCalculatorPageState();
}

class _TotalFertilizerNeededCalculatorPageState
    extends State<TotalFertilizerNeededCalculatorPage> {
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String _selectedAreaUnit = 'ha';

  double? _totalKg;
  double? _totalBags;

  void _calculate() {
    final double? rate = double.tryParse(_rateController.text.trim());
    final double? areaInput = double.tryParse(_areaController.text.trim());

    if (rate == null || rate <= 0) {
      _showError('Please enter a valid fertilizer rate (kg/ha).');
      return;
    }

    if (areaInput == null || areaInput <= 0) {
      _showError('Please enter a valid field area.');
      return;
    }

    double areaHa;

    switch (_selectedAreaUnit) {
      case 'ha':
        areaHa = areaInput;
        break;
      case 'm²':
        areaHa = areaInput / 10000;
        break;
      case 'acre':
        areaHa = areaInput * 0.40468564224;
        break;
      default:
        areaHa = areaInput;
    }

    final double totalKg = rate * areaHa;
    final double totalBags = totalKg / 50; // assuming 50 kg per bag

    setState(() {
      _totalKg = totalKg;
      _totalBags = totalBags;
    });
  }

  void _clearAll() {
    setState(() {
      _rateController.clear();
      _areaController.clear();
      _selectedAreaUnit = 'ha';
      _totalKg = null;
      _totalBags = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildResultCard() {
    if (_totalKg == null) return const SizedBox.shrink();

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
            'Total fertilizer needed = ${_totalKg!.toStringAsFixed(2)} kg',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Equivalent to ${_totalBags!.toStringAsFixed(2)} bags (50 kg/bag)',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rateController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Fertilizer Needed'),
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
              'Calculate total fertilizer needed based on application rate and field area.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _rateController,
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
              controller: _areaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Field area',
                hintText: 'Enter field area',
                prefixIcon: const Icon(Icons.square_foot),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Area Unit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _selectedAreaUnit,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'ha',
                  child: Text('Hectare (ha)'),
                ),
                DropdownMenuItem(
                  value: 'm²',
                  child: Text('Square meter (m²)'),
                ),
                DropdownMenuItem(
                  value: 'acre',
                  child: Text('Acre'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedAreaUnit = value;
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
                      backgroundColor: const Color.fromARGB(255, 138, 242, 178),
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