import 'package:flutter/material.dart';

class SplitApplicationCalculatorPage extends StatefulWidget {
  const SplitApplicationCalculatorPage({super.key});

  @override
  State<SplitApplicationCalculatorPage> createState() =>
      _SplitApplicationCalculatorPageState();
}

class _SplitApplicationCalculatorPageState
    extends State<SplitApplicationCalculatorPage> {
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _splitController = TextEditingController();

  String _selectedUnit = 'kg';

  double? _perSplit;
  List<double> _splitList = [];

  void _calculate() {
    final double? total =
        double.tryParse(_totalController.text.trim());
    final int? splits =
        int.tryParse(_splitController.text.trim());

    if (total == null || total <= 0) {
      _showError('Enter valid total fertilizer');
      return;
    }

    if (splits == null || splits <= 0) {
      _showError('Enter valid number of splits');
      return;
    }

    final perSplit = total / splits;

    List<double> splitList = List.generate(
      splits,
      (index) => perSplit,
    );

    setState(() {
      _perSplit = perSplit;
      _splitList = splitList;
    });
  }

  void _clear() {
    setState(() {
      _totalController.clear();
      _splitController.clear();
      _perSplit = null;
      _splitList = [];
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _buildResult() {
    if (_perSplit == null) return const SizedBox();

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
            'Each application = ${_perSplit!.toStringAsFixed(2)} $_selectedUnit',
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 12),

          const Text(
            'Application Schedule:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 6),

          ..._splitList.asMap().entries.map((entry) {
            return Text(
              'Split ${entry.key + 1}: ${entry.value.toStringAsFixed(2)} $_selectedUnit',
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _totalController.dispose();
    _splitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Application'),
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
              'Divide total fertilizer into multiple applications.',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _totalController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Total fertilizer amount',
                prefixIcon: const Icon(Icons.eco),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedUnit,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'kg', child: Text('kg')),
                DropdownMenuItem(value: 'g', child: Text('g')),
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
              controller: _splitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of splits',
                prefixIcon: const Icon(Icons.format_list_numbered),
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