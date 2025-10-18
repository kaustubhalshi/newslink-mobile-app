import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/core/constants/app_strings.dart';
import 'package:newsapp/core/constants/app_colors.dart';
import 'package:newsapp/core/themes/theme_provider.dart';
import 'package:newsapp/screens/explore/explore_screen.dart';
import 'package:newsapp/screens/search/search_screen.dart';
import 'package:newsapp/screens/bookmarks/bookmarks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ExploreScreen(),
    const SearchScreen(),
    const BookmarksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      // Floating Bottom Navigation Bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            height: 70,
            elevation: 0,
            backgroundColor: isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            indicatorColor: AppColors.primaryPink.withOpacity(0.2),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.explore_outlined,
                  color: _selectedIndex == 0
                      ? AppColors.primaryPink
                      : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                ),
                selectedIcon: const Icon(
                  Icons.explore,
                  color: AppColors.primaryPink,
                ),
                label: AppStrings.explore,
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.search_outlined,
                  color: _selectedIndex == 1
                      ? AppColors.primaryPink
                      : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                ),
                selectedIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryPink,
                ),
                label: AppStrings.search,
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.bookmark_outline,
                  color: _selectedIndex == 2
                      ? AppColors.primaryPink
                      : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                ),
                selectedIcon: const Icon(
                  Icons.bookmark,
                  color: AppColors.primaryPink,
                ),
                label: AppStrings.bookmarks,
              ),
            ],
          ),
        ),
      ),
      // Add padding to prevent content from going under the floating nav bar
      extendBody: false,
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return AppStrings.explore;
      case 1:
        return AppStrings.search;
      case 2:
        return AppStrings.bookmarks;
      default:
        return AppStrings.appName;
    }
  }
}
