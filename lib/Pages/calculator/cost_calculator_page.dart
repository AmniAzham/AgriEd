import 'package:flutter/material.dart';

class CostCalculatorPage extends StatefulWidget {
  const CostCalculatorPage({super.key});

  @override
  State<CostCalculatorPage> createState() => _CostCalculatorPageState();
}

class _CostCalculatorPageState extends State<CostCalculatorPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String _pricingMode = 'Price per kg';

  double? _totalCost;
  double? _bagsNeeded;

  void _calculate() {
    final double? amount = double.tryParse(_amountController.text.trim());
    final double? price = double.tryParse(_priceController.text.trim());

    if (amount == null || amount <= 0) {
      _showError('Please enter a valid fertilizer amount.');
      return;
    }

    if (price == null || price <= 0) {
      _showError('Please enter a valid price.');
      return;
    }

    double totalCost;
    final bagsNeeded = amount / 50;

    if (_pricingMode == 'Price per kg') {
      totalCost = amount * price;
    } else {
      totalCost = bagsNeeded * price;
    }

    setState(() {
      _totalCost = totalCost;
      _bagsNeeded = bagsNeeded;
    });
  }

  void _clearAll() {
    setState(() {
      _amountController.clear();
      _priceController.clear();
      _pricingMode = 'Price per kg';
      _totalCost = null;
      _bagsNeeded = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildResultCard() {
    if (_totalCost == null) return const SizedBox.shrink();

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
            'Fertilizer needed = ${_amountController.text} kg',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Equivalent to ${_bagsNeeded!.toStringAsFixed(2)} bags (50 kg/bag)',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Total cost = RM ${_totalCost!.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getPriceLabel() {
    return _pricingMode == 'Price per kg'
        ? 'Price per kg (RM)'
        : 'Price per 50 kg bag (RM)';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cost Calculator'),
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
              'Estimate fertilizer cost based on amount needed and product price.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Fertilizer amount needed (kg)',
                hintText: 'Enter fertilizer amount',
                prefixIcon: const Icon(Icons.scale),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Pricing Mode',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _pricingMode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Price per kg',
                  child: Text('Price per kg'),
                ),
                DropdownMenuItem(
                  value: 'Price per bag',
                  child: Text('Price per 50 kg bag'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _pricingMode = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _getPriceLabel(),
                hintText: 'Enter price',
                prefixIcon: const Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
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