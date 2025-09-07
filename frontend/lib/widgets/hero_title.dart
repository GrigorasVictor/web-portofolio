import 'package:flutter/material.dart';
import 'typing_title.dart';
import '../theme/colors.dart' as theme_colors;

class HeroTitle extends StatelessWidget {
  final List<String> words;

  const HeroTitle({
    super.key,
    required this.words,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      // Font mare, proporțional cu lățimea ecranului
      final fs = (c.maxWidth * 0.14).clamp(48.0, 160.0);

      // Stil pentru "hello" - foarte mare și foarte gros
      final helloStyle = TextStyle(
        fontSize: fs,
        fontWeight: FontWeight.w900, // Foarte gros
        height: 1.05,
        letterSpacing: -1.5,
        color: theme_colors.kPortfolioTextPrimary, // Culoare actualizată
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

      // Stil pentru textul care se șterge - la fel de mare, dar mai puțin gros
      final typingStyle = helloStyle.copyWith(
        fontWeight: FontWeight.w700, // Gros, dar mai puțin ca 'hello'
        color: theme_colors.kPortfolioTextSecondary, // Culoare actualizată
        shadows: [], // Fără umbră pentru lizibilitate
      );

      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          Text('Hello ', style: helloStyle),
          TypingTitle(words: words, style: typingStyle),
        ],
      );
    });
  }
}
