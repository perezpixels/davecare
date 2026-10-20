import 'package:flutter/material.dart';

class StitchEmbed extends StatelessWidget {
  const StitchEmbed({super.key, required this.html, required this.onRoute});

  final String html;
  final void Function(String route) onRoute;

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFFFAF8FF),
      child: Center(child: Text('Open on Chrome to view Stitch mobile UI')),
    );
  }
}
