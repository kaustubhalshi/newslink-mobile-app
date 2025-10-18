class ApiConstants {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = '46d0c2abbe674bcfa2bc3f640115b57d';

  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';
  static const String sources = '/sources';

  static const String defaultCountry = 'us';
  static const int defaultPageSize = 20;

  static const List<String> categories = [
    'general',
    'technology',
    'sports',
    'business',
    'entertainment',
    'health',
    'science',
  ];
}
