import 'package:flutter/material.dart';
import 'models/experience.dart';
import 'widgets/experience_section.dart';
import 'theme/colors.dart' as theme_colors;
import 'widgets/about_section.dart';
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _aboutKey = GlobalKey();

  // This would be fetched from an API in a real app
  final List<Experience> _experiences = [
    Experience.fromJson({
      "degree": "Bachelor of Science in Computer Science",
      "institution": "Technical University of Cluj-Napoca",
      "location": "Cluj-Napoca, Romania",
      "startDate": "2022-09-01",
      "endDate": "2026-06-30",
      "photoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmYQqhxLrRE4BtyFFAqHyUfDZDceW6oDBDcDZV3w6jJjES"
    }),
    Experience.fromJson({
      "degree": "Licensed in Mathematics-Informatics, intensive in informatics",
      "institution": "‘Dimitrie Cantemir’ National College",
      "location": "Bacău, Romania",
      "startDate": "2018-09-01",
      "endDate": "2022-06-30",
      "photoUrl": "https://steep-cyan-anaconda.myfilebase.com/ipfs/QmbbEDeuwMgLp1Hvq1Zry1SJbciMAoiZdAU5Q9YgD1as3M"
    })
  ];

  Future<void> _scrollToAbout() async {
    final context = _aboutKey.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      const HeroTitle(
                        words: ['everyone', 'people', 'world'],
                      ),
                      const Spacer(flex: 1),
                      IconButton(
                        onPressed: _scrollToAbout,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 32,
                        color: theme_colors.kPortfolioTextSecondary,
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
                  child: AboutSection(key: _aboutKey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
                  child: ExperienceSection(experiences: _experiences),
                ),
                SizedBox(height: h * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

