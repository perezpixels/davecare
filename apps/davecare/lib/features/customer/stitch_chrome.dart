import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/davecare_theme.dart';

/// Centers a phone-width column so web preview matches Stitch mobile mocks.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth > 430 ? 430.0 : constraints.maxWidth;
        return ColoredBox(
          color: const Color(0xFFE8ECF8),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: width,
              height: constraints.maxHeight,
              child: ColoredBox(color: DcColors.background, child: child),
            ),
          ),
        );
      },
    );
  }
}

class StitchHeader extends StatelessWidget {
  const StitchHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.online = false,
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final bool online;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DcColors.surface.withValues(alpha: 0.94),
      padding: const EdgeInsets.fromLTRB(8, 6, 12, 8),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/get-started');
                }
              },
              icon: const Icon(Icons.arrow_back),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.local_pharmacy, color: DcColors.primaryContainer),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (online)
                  const Text(
                    'Pharm. David is Online',
                    style: TextStyle(color: DcColors.secondary, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: DcColors.onSurface),
                ),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(fontSize: 11, color: DcColors.onSurfaceVariant)),
              ],
            ),
          ),
          Stack(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: DcColors.error, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 14,
            backgroundColor: DcColors.secondaryContainer,
            child: Text('AM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: DcColors.primary)),
          ),
        ],
      ),
    );
  }
}

class StitchBottomNav extends StatelessWidget {
  const StitchBottomNav({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    Widget item(int i, IconData icon, String label, {int badge = 0}) {
      final on = i == index;
      return Expanded(
        child: InkWell(
          onTap: () {
            switch (i) {
              case 0:
                context.go('/home');
              case 1:
                context.go('/shop');
              case 2:
                context.go('/orders');
              case 3:
                context.go('/health');
              case 4:
                context.go('/profile');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(icon, color: on ? DcColors.primary : DcColors.onSurfaceVariant, size: 24),
                    if (badge > 0)
                      Positioned(
                        right: -8,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: const BoxDecoration(color: DcColors.primary, borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Text('$badge', style: const TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: on ? FontWeight.w700 : FontWeight.w500,
                    color: on ? DcColors.primary : DcColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      color: DcColors.surfaceLowest,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            item(0, Icons.home, 'Home'),
            item(1, Icons.local_pharmacy, 'Shop'),
            item(2, Icons.receipt_long, 'Orders', badge: 1),
            item(3, Icons.health_and_safety, 'Health'),
            item(4, Icons.person, 'Profile'),
          ],
        ),
      ),
    );
  }
}

class Pill extends StatelessWidget {
  const Pill(this.label, {super.key, this.bg = DcColors.secondaryContainer, this.fg = DcColors.onSecondaryContainer});

  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class SoftCard extends StatelessWidget {
  const SoftCard({super.key, required this.child, this.color, this.padding, this.onTap});

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? DcColors.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 1))],
      ),
      child: child,
    );
    if (onTap == null) return box;
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: box);
  }
}
