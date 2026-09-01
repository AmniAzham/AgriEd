import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedItemsService extends ChangeNotifier {
  static const String _storageKey = 'saved_items';

  final List<Map<String, dynamic>> _savedItems = [];

  List<Map<String, dynamic>> get savedItems => List.unmodifiable(_savedItems);

  Future<void> loadSavedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> rawItems = prefs.getStringList(_storageKey) ?? [];

    _savedItems
      ..clear()
      ..addAll(
        rawItems.map((item) => jsonDecode(item) as Map<String, dynamic>),
      );

    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final rawItems = _savedItems.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(_storageKey, rawItems);
  }

  bool isSaved(String id) {
    return _savedItems.any((item) => item['id'] == id);
  }

Future<void> toggleSaved(Map<String, dynamic> item) async {
  final index = _savedItems.indexWhere((e) => e['id'] == item['id']);

  if (index >= 0) {
    _savedItems.removeAt(index);
  } else {
    _savedItems.add(item);
  }

  notifyListeners(); // update UI immediately

  try {
    await _persist(); // save after UI updates
  } catch (e) {
    debugPrint('Persist error: $e');
  }
}
}