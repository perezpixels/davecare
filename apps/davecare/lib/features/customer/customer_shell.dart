import 'package:flutter/material.dart';

/// Customer chrome lives in Stitch HTML (status bar + tab bar). Do not wrap a second nav.
class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
