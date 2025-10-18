import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/core/constants/app_strings.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:newsapp/screens/explore/widgets/news_card.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, _) {
        if (bookmarkProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookmarkProvider.bookmarks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  AppStrings.noBookmarks,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookmarkProvider.bookmarks.length,
          itemBuilder: (context, index) {
            return NewsCard(article: bookmarkProvider.bookmarks[index]);
          },
        );
      },
    );
  }
}
