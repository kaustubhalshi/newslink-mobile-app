import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newsapp/models/article_model.dart';

class BookmarkService {
  static const String _bookmarksKey = 'bookmarks';

  Future<List<Article>> getBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarksJson = prefs.getStringList(_bookmarksKey) ?? [];

      return bookmarksJson
          .map((json) => Article.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();

    if (!bookmarks.any((a) => a.url == article.url)) {
      bookmarks.insert(0, article);
      await _saveBookmarks(prefs, bookmarks);
    }
  }

  Future<void> removeBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();

    bookmarks.removeWhere((a) => a.url == article.url);
    await _saveBookmarks(prefs, bookmarks);
  }

  Future<bool> isBookmarked(Article article) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((a) => a.url == article.url);
  }

  Future<void> _saveBookmarks(SharedPreferences prefs, List<Article> bookmarks) async {
    final bookmarksJson = bookmarks
        .map((article) => jsonEncode(article.toJson()))
        .toList();
    await prefs.setStringList(_bookmarksKey, bookmarksJson);
  }
}
