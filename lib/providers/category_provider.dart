import 'package:flutter/material.dart';
import 'package:newsapp/core/constants/api_constants.dart';

class CategoryProvider with ChangeNotifier {
  List<String> _selectedCategories = ['general'];

  List<String> get selectedCategories => _selectedCategories;
  List<String> get allCategories => ApiConstants.categories;

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      if (_selectedCategories.length > 1) {
        _selectedCategories.remove(category);
      }
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  void resetCategories() {
    _selectedCategories = ['general'];
    notifyListeners();
  }
}
