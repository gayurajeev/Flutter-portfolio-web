import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class ScrollReveal extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double baseOpacity;
  final double baseRotation;
  final double blurStrength;
  final bool enableBlur;
  final TextAlign textAlign;

  const ScrollReveal({
    super.key,
    required this.text,
    this.style,
    this.baseOpacity = 0.1,
    this.baseRotation = 3.0,
    this.blurStrength = 4.0,
    this.enableBlur = true,
    this.textAlign = TextAlign.start,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  final GlobalKey _anchorKey = GlobalKey();
  late List<String> _words;

  @override
  void initState() {
    super.initState();
    _words = widget.text.split(RegExp(r'\s+'));
  }

  @override
  void didUpdateWidget(ScrollReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _words = widget.text.split(RegExp(r'\s+'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollable = Scrollable.maybeOf(context);

    if (scrollable == null) {
      return Text(widget.text, style: widget.style, textAlign: widget.textAlign);
    }

    return AnimatedBuilder(
      animation: scrollable.position,
      builder: (context, child) {
        double progress = 0.0;
        double rotationProgress = 0.0;

        try {
          final RenderObject? scrollRenderObject = scrollable.context.findRenderObject();
          final RenderBox? box = _anchorKey.currentContext?.findRenderObject() as RenderBox?;

          if (scrollRenderObject != null && box != null) {
            final RenderBox scrollBox = scrollRenderObject as RenderBox;
            final double viewportHeight = scrollBox.size.height;
            final double y = box.localToGlobal(Offset.zero, ancestor: scrollRenderObject).dy;

            // Rotation animation progress (starts when element enters screen, ends earlier)
            final double rotStartY = viewportHeight;
            final double rotEndY = viewportHeight * 0.7;
            rotationProgress = ((rotStartY - y) / (rotStartY - rotEndY)).clamp(0.0, 1.0);

            // Words animation progress
            final double startY = viewportHeight * 0.9;
            final double endY = viewportHeight * 0.6;
            progress = ((startY - y) / (startY - endY)).clamp(0.0, 1.0);
          }
        } catch (_) {}

        final double currentRotation = widget.baseRotation * (1.0 - rotationProgress) * (math.pi / 180);

        return Transform(
          transform: Matrix4.identity()..rotateZ(currentRotation),
          alignment: Alignment.centerLeft,
          child: Container(
            key: _anchorKey,
            child: Wrap(
              alignment: _getWrapAlignment(widget.textAlign),
              spacing: _getSpaceWidth(widget.style),
              runSpacing: 4.0, // Adjust based on line height if needed
              children: List.generate(_words.length, (i) {
                final double wordDuration = 0.2;
                final double stagger = _words.length > 1 
                    ? (1.0 - wordDuration) / (_words.length - 1) 
                    : 0;
                final double wordStart = stagger * i;
                final double wordProgress = ((progress - wordStart) / wordDuration).clamp(0.0, 1.0);

                final double opacity = widget.baseOpacity + (1.0 - widget.baseOpacity) * wordProgress;
                final double blur = widget.enableBlur 
                    ? widget.blurStrength * (1.0 - wordProgress) 
                    : 0.0;

                Widget wordWidget = Text(_words[i], style: widget.style);

                if (widget.enableBlur && blur > 0) {
                  wordWidget = ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                    child: wordWidget,
                  );
                }

                return Opacity(
                  opacity: opacity,
                  child: wordWidget,
                );
              }),
            ),
          ),
        );
      },
    );
  }

  double _getSpaceWidth(TextStyle? style) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: ' ', style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.size.width;
  }

  WrapAlignment _getWrapAlignment(TextAlign align) {
    switch (align) {
      case TextAlign.center:
        return WrapAlignment.center;
      case TextAlign.right:
      case TextAlign.end:
        return WrapAlignment.end;
      case TextAlign.justify:
        return WrapAlignment.spaceBetween;
      default:
        return WrapAlignment.start;
    }
  }
}
