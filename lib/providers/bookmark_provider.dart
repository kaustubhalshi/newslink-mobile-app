import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/bookmark_service.dart';

class BookmarkProvider with ChangeNotifier {
  final BookmarkService _bookmarkService = BookmarkService();
  List<Article> _bookmarks = [];
  bool _isLoading = false;

  List<Article> get bookmarks => _bookmarks;
  bool get isLoading => _isLoading;

  BookmarkProvider() {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    _isLoading = true;
    notifyListeners();

    _bookmarks = await _bookmarkService.getBookmarks();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleBookmark(Article article) async {
    final isBookmarked = await _bookmarkService.isBookmarked(article);

    if (isBookmarked) {
      await _bookmarkService.removeBookmark(article);
    } else {
      await _bookmarkService.addBookmark(article);
    }

    await loadBookmarks();
  }

  Future<bool> isBookmarked(Article article) async {
    return await _bookmarkService.isBookmarked(article);
  }
}
