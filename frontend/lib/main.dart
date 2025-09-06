import 'package:flutter/material.dart';
import 'models/education.dart';
import 'models/experience.dart';
import 'models/project.dart';
import 'sections/experience_section.dart';
import 'sections/project_section.dart';
import 'services/api_service.dart';
import 'sections/education_section.dart';
import 'theme/colors.dart' as theme_colors;
import 'sections/about_section.dart';
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
  final ApiService _apiService = ApiService();
  late final Future<List<Education>> _educationFuture;
  late final Future<List<Experience>> _experienceFuture;
  late final Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _educationFuture = _apiService.fetchEducation();
    _experienceFuture = _apiService.fetchExperience();
    _projectsFuture = _apiService.fetchProjects();
  }

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
                  child: FutureBuilder<List<Education>>(
                    future: _educationFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const EducationSection(educations: null); // Loading state
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                        return const EducationSection(educations: []); // Error/Empty state
                      } else {
                        return EducationSection(educations: snapshot.data!); // Data state
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
                  child: FutureBuilder<List<Experience>>(
                    future: _experienceFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ExperienceSection(experiences: null); // Loading state
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                        return const ExperienceSection(experiences: []); // Error/Empty state
                      } else {
                        return ExperienceSection(experiences: snapshot.data!); // Data state
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
                  child: FutureBuilder<List<Project>>(
                    future: _projectsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ProjectSection(projects: null); // Loading state
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                        return const ProjectSection(projects: []); // Error/Empty state
                      } else {
                        return ProjectSection(projects: snapshot.data!); // Data state
                      }
                    },
                  ),
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

