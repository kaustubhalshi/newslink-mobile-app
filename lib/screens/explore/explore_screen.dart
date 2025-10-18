import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:newsapp/core/constants/api_constants.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/screens/explore/widgets/news_card.dart';
import 'package:newsapp/screens/explore/widgets/category_tab_bar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNews(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTabBar(
          categories: ApiConstants.categories,
          onCategorySelected: (category) {
            Provider.of<NewsProvider>(context, listen: false).setCategory(category);
          },
        ),
        Expanded(
          child: Consumer<NewsProvider>(
            builder: (context, newsProvider, _) {
              if (newsProvider.isLoading && newsProvider.articles.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (newsProvider.error != null && newsProvider.articles.isEmpty) {
                return Center(child: Text(newsProvider.error!));
              }

              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await newsProvider.fetchNews(refresh: true);
                  _refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await newsProvider.fetchNews();
                  _refreshController.loadComplete();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: newsProvider.articles.length,
                  itemBuilder: (context, index) {
                    return NewsCard(article: newsProvider.articles[index]);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
