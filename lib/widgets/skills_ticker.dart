import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SkillsTicker extends StatefulWidget {
  const SkillsTicker({super.key});

  @override
  State<SkillsTicker> createState() => _SkillsTickerState();
}

class _SkillsTickerState extends State<SkillsTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const List<String> _skills = [
    'Python',
    '·',
    'R',
    '·',
    'Excel',
    '·',
    'Tableau',
    '·',
    'SQL',
    '·',
    'Data Visualization',
    '·',
    'Flutter',
    '·',
    'Web Development',
    '·',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      height: 100,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: _TickerPainter(
                skills: _skills,
                progress: _animation.value,
                style: AppTextStyles.marqueeText,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ),
    );
  }
}

class _TickerPainter extends CustomPainter {
  final List<String> skills;
  final double progress;
  final TextStyle style;

  _TickerPainter({
    required this.skills,
    required this.progress,
    required this.style,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fullText = skills.join('  ');
    final textPainter = TextPainter(
      text: TextSpan(text: fullText + '  ' + fullText, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final offset = progress * textPainter.width / 2;
    textPainter.paint(canvas, Offset(-offset, (size.height - textPainter.height) / 2));
  }

  @override
  bool shouldRepaint(_TickerPainter old) => old.progress != progress;
}
