import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/api_service.dart';

class NewsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'general';
  int _currentPage = 1;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  Future<void> fetchNews({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _articles = [];
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newArticles = await _apiService.getTopHeadlines(
        category: _selectedCategory,
        page: _currentPage,
      );

      if (refresh) {
        _articles = newArticles;
      } else {
        _articles.addAll(newArticles);
      }

      _currentPage++;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      fetchNews(refresh: true);
    }
  }
}
