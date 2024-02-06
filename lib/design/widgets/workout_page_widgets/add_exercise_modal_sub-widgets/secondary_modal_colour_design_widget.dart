import 'package:flutter/material.dart';

import 'dart:math' as math;

class SecondaryModalColourDesign extends StatelessWidget {
  final Color secondaryMuscleColour;

  const SecondaryModalColourDesign({
    super.key,
    required this.secondaryMuscleColour,
  });

  @override
  Widget build(BuildContext context) {
    Duration animationDuration = const Duration(milliseconds: 350);
    double xAlignmentOffset = 0;
    double yAlignmentOffset = 0.15;

    return Stack(children: [
      DesignBox(
          xAlignmentBase: 0,
          xAlignmentOffset: xAlignmentOffset,
          yAlignmentBase: 1.5,
          yAlignmentOffset: yAlignmentOffset,
          animationDuration: animationDuration,
          secondaryMuscleColour: secondaryMuscleColour),
      DesignBox(
          xAlignmentBase: 0.25 + 0.09,
          xAlignmentOffset: xAlignmentOffset,
          yAlignmentBase: 1.52,
          yAlignmentOffset: yAlignmentOffset,
          animationDuration: animationDuration,
          secondaryMuscleColour: Color(secondaryMuscleColour.value)),
      DesignBox(
          xAlignmentBase: 0.8,
          xAlignmentOffset: xAlignmentOffset,
          yAlignmentBase: 1.57,
          yAlignmentOffset: yAlignmentOffset,
          animationDuration: animationDuration,
          secondaryMuscleColour: secondaryMuscleColour),
    ]);
  }
}

class DesignBox extends StatelessWidget {
  const DesignBox({
    super.key,
    required this.xAlignmentBase,
    required this.yAlignmentBase,
    required this.animationDuration,
    required this.secondaryMuscleColour,
    required this.xAlignmentOffset,
    required this.yAlignmentOffset,
  });

  final double xAlignmentBase;
  final double xAlignmentOffset;
  final double yAlignmentBase;
  final double yAlignmentOffset;
  final Duration animationDuration;
  final Color secondaryMuscleColour;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      alignment: Alignment(
          xAlignmentBase + xAlignmentOffset,
          yAlignmentBase + yAlignmentOffset
      ),
      angle: -math.pi * 0.92,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
          width: 1000,
          height: 400,
          duration: animationDuration,
          color: secondaryMuscleColour,
        ),
      Container(color: Colors.white.withOpacity(0.7),
      width: 1000,
          height: 300,)
        ]
      ),
    );
  }
}
