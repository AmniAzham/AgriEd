import 'package:flutter/material.dart';

class NpkConversionCalculatorPage extends StatefulWidget {
  const NpkConversionCalculatorPage({super.key});

  @override
  State<NpkConversionCalculatorPage> createState() =>
      _NpkConversionCalculatorPageState();
}

class _NpkConversionCalculatorPageState
    extends State<NpkConversionCalculatorPage> {
  final TextEditingController _inputController = TextEditingController();

  String _selectedConversion = 'P → P₂O₅';
  double? _result;

  void _calculate() {
    final double? inputValue = double.tryParse(_inputController.text.trim());

    if (inputValue == null || inputValue < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid value')),
      );
      return;
    }

    double output;

    switch (_selectedConversion) {
      case 'P → P₂O₅':
        output = inputValue * 2.29;
        break;
      case 'P₂O₅ → P':
        output = inputValue * 0.437;
        break;
      case 'K → K₂O':
        output = inputValue * 1.20;
        break;
      case 'K₂O → K':
        output = inputValue * 0.830;
        break;
      default:
        output = inputValue;
    }

    setState(() {
      _result = output;
    });
  }

  void _clearAll() {
    setState(() {
      _inputController.clear();
      _selectedConversion = 'P → P₂O₅';
      _result = null;
    });
  }

  String _getInputLabel() {
    switch (_selectedConversion) {
      case 'P → P₂O₅':
        return 'Enter P value';
      case 'P₂O₅ → P':
        return 'Enter P₂O₅ value';
      case 'K → K₂O':
        return 'Enter K value';
      case 'K₂O → K':
        return 'Enter K₂O value';
      default:
        return 'Enter value';
    }
  }

  String _getResultText() {
    if (_result == null) return '';

    return '${_inputController.text} = ${_result!.toStringAsFixed(3)}';
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
            _getResultText(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedConversion,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Common Factors',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('P × 2.29 = P₂O₅'),
          Text('P₂O₅ × 0.437 = P'),
          SizedBox(height: 6),
          Text('K × 1.20 = K₂O'),
          Text('K₂O × 0.830 = K'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('NPK Conversion'),
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
              'Convert phosphorus and potassium between elemental and oxide forms.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Select Conversion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _selectedConversion,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'P → P₂O₅',
                  child: Text('P → P₂O₅'),
                ),
                DropdownMenuItem(
                  value: 'P₂O₅ → P',
                  child: Text('P₂O₅ → P'),
                ),
                DropdownMenuItem(
                  value: 'K → K₂O',
                  child: Text('K → K₂O'),
                ),
                DropdownMenuItem(
                  value: 'K₂O → K',
                  child: Text('K₂O → K'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedConversion = value;
                    _result = null;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _getInputLabel(),
                hintText: 'Enter value',
                prefixIcon: const Icon(Icons.swap_horiz),
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
                      backgroundColor: const Color.fromARGB(255, 138, 242, 178),
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
            const SizedBox(height: 16),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }
}