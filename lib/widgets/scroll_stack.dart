import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScrollStack extends StatefulWidget {
  final List<Widget> children;
  final double itemDistance;
  final double itemStackDistance;
  final double stackPosition; // Percentage of viewport height (0 to 1)
  final double scaleEndPosition; // Percentage of viewport height (0 to 1)
  final double baseScale;
  final double itemScale;
  final double rotationAmount; // Not fully implemented in standard stack but available
  final double blurAmount;

  const ScrollStack({
    super.key,
    required this.children,
    this.itemDistance = 100, // Margin between unpinned items
    this.itemStackDistance = 30, // Distance between items when stacked
    this.stackPosition = 0.20, // 20%
    this.scaleEndPosition = 0.10, // 10%
    this.baseScale = 0.85,
    this.itemScale = 0.03,
    this.rotationAmount = 0,
    this.blurAmount = 0,
  });

  @override
  State<ScrollStack> createState() => _ScrollStackState();
}

class _ScrollStackState extends State<ScrollStack> {
  final GlobalKey _endAnchorKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.children.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom: i < widget.children.length - 1 ? widget.itemDistance : 0,
            ),
            child: _ScrollStackItem(
              index: i,
              totalItems: widget.children.length,
              endAnchorKey: _endAnchorKey,
              itemStackDistance: widget.itemStackDistance,
              stackPosition: widget.stackPosition,
              scaleEndPosition: widget.scaleEndPosition,
              baseScale: widget.baseScale,
              itemScale: widget.itemScale,
              rotationAmount: widget.rotationAmount,
              blurAmount: widget.blurAmount,
              child: widget.children[i],
            ),
          ),
        // Add a spacer equal to screen height so the last item stays pinned while scrolling
        SizedBox(height: MediaQuery.of(context).size.height * 0.8),
        // The end element to determine when to unpin the stack
        SizedBox(
          key: _endAnchorKey,
          width: double.infinity,
          height: 1, // small spacer
        ),
      ],
    );
  }
}

class _ScrollStackItem extends StatefulWidget {
  final int index;
  final int totalItems;
  final GlobalKey endAnchorKey;
  final Widget child;
  
  final double itemStackDistance;
  final double stackPosition;
  final double scaleEndPosition;
  final double baseScale;
  final double itemScale;
  final double rotationAmount;
  final double blurAmount;

  const _ScrollStackItem({
    required this.index,
    required this.totalItems,
    required this.endAnchorKey,
    required this.child,
    required this.itemStackDistance,
    required this.stackPosition,
    required this.scaleEndPosition,
    required this.baseScale,
    required this.itemScale,
    required this.rotationAmount,
    required this.blurAmount,
  });

  @override
  State<_ScrollStackItem> createState() => _ScrollStackItemState();
}

class _ScrollStackItemState extends State<_ScrollStackItem> {
  final GlobalKey _anchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // We get the nearest Scrollable
    final scrollable = Scrollable.maybeOf(context);

    if (scrollable == null) {
      // If no scrollable, just return the child
      return Container(key: _anchorKey, child: widget.child);
    }

    return AnimatedBuilder(
      animation: scrollable.position,
      builder: (context, child) {
        double translateY = 0.0;
        double scale = 1.0;
        double rotation = 0.0;

        try {
          final RenderObject? scrollRenderObject = scrollable.context.findRenderObject();
          final RenderBox? box = _anchorKey.currentContext?.findRenderObject() as RenderBox?;
          
          if (scrollRenderObject != null && box != null) {
            // Check if the scrollable viewport has constraints
            final RenderBox scrollBox = scrollRenderObject as RenderBox;
            final double viewportHeight = scrollBox.size.height;

            final Offset positionInScrollable = box.localToGlobal(Offset.zero, ancestor: scrollRenderObject);
            final double y = positionInScrollable.dy;

            final double stackPositionPx = viewportHeight * widget.stackPosition;
            final double scaleEndPositionPx = viewportHeight * widget.scaleEndPosition;
            final double targetY = stackPositionPx + widget.itemStackDistance * widget.index;

            // If the item has scrolled past its target pin position
            if (y < targetY) {
              translateY = targetY - y;

              // Calculate scale
              final double progress = ((targetY - y) / (targetY - scaleEndPositionPx)).clamp(0.0, 1.0);
              final double targetScale = widget.baseScale + widget.index * widget.itemScale;
              scale = 1 - progress * (1 - targetScale);
              
              if (widget.rotationAmount != 0) {
                 rotation = widget.index * widget.rotationAmount * progress * (math.pi / 180);
              }

              // Check if stack has ended to unpin
              final RenderBox? endBox = widget.endAnchorKey.currentContext?.findRenderObject() as RenderBox?;
              if (endBox != null) {
                final double endY = endBox.localToGlobal(Offset.zero, ancestor: scrollRenderObject).dy;
                final double unpinY = viewportHeight * 0.15; // Unpin when end reaches near top of screen
                
                if (endY < unpinY) {
                  translateY -= (unpinY - endY);
                  if (translateY < 0) translateY = 0; // prevent moving above original position
                }
              }
            }
          }
        } catch (e) {
          // Catch layout errors during first frame
        }

        return Container(
          key: _anchorKey,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, translateY, 0.0)
              ..scale(scale, scale)
              ..rotateZ(rotation),
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
