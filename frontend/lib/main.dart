import 'package:flutter/material.dart';
import 'theme/colors.dart' as theme_colors;
import 'widgets/hero_title.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: theme_colors.kPortfolioAccent,
      brightness: Brightness.dark,
    ).copyWith(
      background: theme_colors.kPortfolioBackground,
      surface: theme_colors.kPortfolioSurface,
      onBackground: theme_colors.kPortfolioTextSecondary,
      onSurface: theme_colors.kPortfolioTextSecondary,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portofoliu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: theme_colors.kPortfolioBackground,
        textTheme: ThemeData.dark(useMaterial3: true)
            .textTheme
            .apply(displayColor: theme_colors.kPortfolioTextSecondary, bodyColor: theme_colors.kPortfolioTextSecondary),
        appBarTheme: const AppBarTheme(
          backgroundColor: theme_colors.kPortfolioSurface,
          foregroundColor: theme_colors.kPortfolioTextSecondary,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        dividerColor: theme_colors.kPortfolioBorder,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrează conținutul pe verticală
            children: [
              SizedBox(
                height: h * 0.66, // ocupă o parte mare din ecran
                child: const Center(
                  child: HeroTitle(
                    words: ['everyone', 'people', 'world'],
                  ),
                ),
              ),
              // Linia (Divider) a fost eliminată
            ],
          ),
        ),
      ),
    );
  }
}
