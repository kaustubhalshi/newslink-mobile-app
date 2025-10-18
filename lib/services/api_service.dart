import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/core/constants/api_constants.dart';
import 'package:newsapp/models/article_model.dart';

class ApiService {
  Future<List<Article>> getTopHeadlines({
    String? category,
    String? country = 'us',
    int page = 1,
  }) async {
    try {
      final queryParams = {
        'apiKey': ApiConstants.apiKey,
        'country': country ?? ApiConstants.defaultCountry,
        'pageSize': ApiConstants.defaultPageSize.toString(),
        'page': page.toString(),
        if (category != null && category != 'general') 'category': category,
      };

      final uri = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.topHeadlines}'
      ).replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<Article>> searchNews(String query, {int page = 1}) async {
    try {
      final queryParams = {
        'apiKey': ApiConstants.apiKey,
        'q': query,
        'sortBy': 'publishedAt',
        'pageSize': ApiConstants.defaultPageSize.toString(),
        'page': page.toString(),
      };

      final uri = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.everything}'
      ).replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to search news');
      }
    } catch (e) {
      throw Exception('Error searching news: $e');
    }
  }
}
