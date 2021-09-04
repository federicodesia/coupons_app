import 'package:flutter/material.dart';

class ScrollEffect extends StatelessWidget{

  ScrollEffect({
    required this.index,
    required this.currentPage,
    required this.translationFactor,
    required this.opacityFactor,
    required this.child
  });

  final int index;
  final double currentPage;
  final double translationFactor;
  final double opacityFactor;
  final Widget child;

  Widget build(BuildContext context){
    final double percent = (1 - (currentPage - index)).clamp(0.0, 2.0);

    final double value;
    if(percent >= 1.0) value = 1 - (2.0 - percent);
    else value = (1 - percent) * -1;

    final double opacity = ((-opacityFactor + value.abs()) / -opacityFactor).clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(value * translationFactor, 0.0),
        child: child,
      ),
    );
  }
}