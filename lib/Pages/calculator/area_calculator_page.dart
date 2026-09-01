import 'dart:math';
import 'package:flutter/material.dart';

class AreaCalculatorPage extends StatefulWidget {
  const AreaCalculatorPage({super.key});

  @override
  State<AreaCalculatorPage> createState() => _AreaCalculatorPageState();
}

class _AreaCalculatorPageState extends State<AreaCalculatorPage> {
  final TextEditingController _value1Controller = TextEditingController();
  final TextEditingController _value2Controller = TextEditingController();

  String _selectedShape = 'Rectangle';
  String _selectedUnit = 'Meter (m)';

  String _label1 = 'Length';
  String _label2 = 'Width';

  double? _areaM2;
  double? _areaHa;
  double? _areaAcre;

  void _updateLabels() {
    setState(() {
      if (_selectedShape == 'Rectangle') {
        _label1 = 'Length';
        _label2 = 'Width';
      } else if (_selectedShape == 'Triangle') {
        _label1 = 'Base';
        _label2 = 'Height';
      } else if (_selectedShape == 'Circle') {
        _label1 = 'Radius';
        _label2 = '';
        _value2Controller.clear();
      }
    });
  }

  double _convertToMeter(double value) {
    switch (_selectedUnit) {
      case 'Meter (m)':
        return value;
      case 'Kilometer (km)':
        return value * 1000;
      case 'Centimeter (cm)':
        return value / 100;
      case 'Foot (ft)':
        return value * 0.3048;
      default:
        return value;
    }
  }

  void _calculateArea() {
    final double? value1 = double.tryParse(_value1Controller.text.trim());
    final double? value2 = _selectedShape == 'Circle'
        ? null
        : double.tryParse(_value2Controller.text.trim());

    if (value1 == null || value1 <= 0) {
      _showError('Please enter a valid positive value for $_label1.');
      return;
    }

    if (_selectedShape != 'Circle' && (value2 == null || value2 <= 0)) {
      _showError('Please enter a valid positive value for $_label2.');
      return;
    }

    final double v1m = _convertToMeter(value1);
    final double v2m = value2 != null ? _convertToMeter(value2) : 0;

    double area;

    if (_selectedShape == 'Rectangle') {
      area = v1m * v2m;
    } else if (_selectedShape == 'Triangle') {
      area = 0.5 * v1m * v2m;
    } else {
      area = pi * v1m * v1m;
    }

    setState(() {
      _areaM2 = area;
      _areaHa = area / 10000;
      _areaAcre = area / 4046.8564224;
    });
  }

  void _clearAll() {
    setState(() {
      _value1Controller.clear();
      _value2Controller.clear();
      _selectedShape = 'Rectangle';
      _selectedUnit = 'Meter (m)';
      _label1 = 'Length';
      _label2 = 'Width';
      _areaM2 = null;
      _areaHa = null;
      _areaAcre = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildResultCard() {
    if (_areaM2 == null) return const SizedBox.shrink();

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
            'Area = ${_areaM2!.toStringAsFixed(2)} m²',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Area = ${_areaHa!.toStringAsFixed(4)} ha',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            'Area = ${_areaAcre!.toStringAsFixed(4)} acre',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _value1Controller.dispose();
    _value2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCircle = _selectedShape == 'Circle';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Calculator'),
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
              'Calculate land area based on shape and unit.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Select Shape',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedShape,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Rectangle',
                  child: Text('Rectangle'),
                ),
                DropdownMenuItem(
                  value: 'Triangle',
                  child: Text('Triangle'),
                ),
                DropdownMenuItem(
                  value: 'Circle',
                  child: Text('Circle'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  _selectedShape = value;
                  _updateLabels();
                }
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Select Unit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedUnit,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Meter (m)',
                  child: Text('Meter (m)'),
                ),
                DropdownMenuItem(
                  value: 'Kilometer (km)',
                  child: Text('Kilometer (km)'),
                ),
                DropdownMenuItem(
                  value: 'Centimeter (cm)',
                  child: Text('Centimeter (cm)'),
                ),
                DropdownMenuItem(
                  value: 'Foot (ft)',
                  child: Text('Foot (ft)'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedUnit = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _value1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _label1,
                hintText: 'Enter $_label1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                prefixIcon: const Icon(Icons.straighten),
              ),
            ),

            const SizedBox(height: 16),

            if (!isCircle)
              TextField(
                controller: _value2Controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: _label2,
                  hintText: 'Enter $_label2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  prefixIcon: const Icon(Icons.straighten),
                ),
              ),

            if (!isCircle) const SizedBox(height: 20),
            if (isCircle) const SizedBox(height: 4),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateArea,
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