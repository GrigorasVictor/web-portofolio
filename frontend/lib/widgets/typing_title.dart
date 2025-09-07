import 'dart:async';
import 'package:flutter/material.dart';

class TypingTitle extends StatefulWidget {
  final List<String> words;
  final Duration typingDelay;
  final Duration pause;
  final TextStyle? style;

  const TypingTitle({
    super.key,
    required this.words,
    this.typingDelay = const Duration(milliseconds: 80),
    this.pause = const Duration(milliseconds: 900),
    this.style,
  });

  @override
  State<TypingTitle> createState() => _TypingTitleState();
}

class _TypingTitleState extends State<TypingTitle> {
  int _wordIndex = 0;
  String _typed = '';
  bool _cursorOn = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;
      setState(() => _cursorOn = !_cursorOn);
    });
    _runLoop();
  }

  Future<void> _runLoop() async {
    while (mounted && widget.words.isNotEmpty) {
      final word = widget.words[_wordIndex];

      // Type
      for (var i = 1; i <= word.length && mounted; i++) {
        setState(() => _typed = word.substring(0, i));
        await Future.delayed(widget.typingDelay);
      }
      await Future.delayed(widget.pause);

      for (var i = word.length - 1; i >= 0 && mounted; i--) {
        setState(() => _typed = word.substring(0, i));
        await Future.delayed(widget.typingDelay);
      }

      _wordIndex = (_wordIndex + 1) % widget.words.length;
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = '$_typed${_cursorOn ? '|' : ''}';
    return Text(text, style: widget.style ?? Theme.of(context).textTheme.headlineMedium);
  }
}
