import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:newsapp/core/constants/app_colors.dart';
import 'package:newsapp/core/constants/app_strings.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:newsapp/screens/web_view/web_view_screen.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: article.urlToImage != null
                  ? CachedNetworkImage(
                imageUrl: article.urlToImage!,
                fit: BoxFit.cover,
              )
                  : Container(color: Colors.grey),
            ),
            actions: [
              Consumer<BookmarkProvider>(
                builder: (context, bookmarkProvider, _) {
                  return FutureBuilder<bool>(
                    future: bookmarkProvider.isBookmarked(article),
                    builder: (context, snapshot) {
                      final isBookmarked = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        onPressed: () {
                          bookmarkProvider.toggleBookmark(article);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isBookmarked
                                    ? AppStrings.bookmarkRemoved
                                    : AppStrings.bookmarkAdded,
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        article.source.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (article.publishedAt != null)
                        Text(
                          '• ${timeago.format(article.publishedAt!)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  if (article.author != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'By ${article.author}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (article.description != null) ...[
                    Text(
                      article.description!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (article.content != null)
                    Text(
                      article.content!.replaceAll(RegExp(r'\[\+\d+ chars\]'), ''),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  const SizedBox(height: 24),
                  if (article.url != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _openInWebView(context),  // Updated method
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.primaryPink,
                        ),
                        child: const Text(
                          AppStrings.readMore,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Updated method to open in WebView
  void _openInWebView(BuildContext context) {
    if (article.url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(
            url: article.url!,
            title: article.source.name,
          ),
        ),
      );
    }
  }
}
