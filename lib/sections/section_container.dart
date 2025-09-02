import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? background;

  const SectionContainer({super.key, required this.child, this.background});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontal = width < 700
        ? 16.0
        : width < 1100
            ? 32.0
            : 64.0;
    return Container(
      color: background,
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 48),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: child,
      ),
    );
  }
}

