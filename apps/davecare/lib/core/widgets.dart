import 'package:flutter/material.dart';

import '../theme/davecare_theme.dart';

class DcBadge extends StatelessWidget {
  const DcBadge({
    super.key,
    required this.label,
    this.tone = DcBadgeTone.success,
  });

  final String label;
  final DcBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      DcBadgeTone.success => (DcColors.successBg, DcColors.successFg),
      DcBadgeTone.warning => (DcColors.warningBg, DcColors.warningFg),
      DcBadgeTone.danger => (DcColors.errorContainer, DcColors.error),
      DcBadgeTone.info => (DcColors.infoBg, DcColors.infoFg),
      DcBadgeTone.teal => (DcColors.secondaryContainer, DcColors.onSecondaryContainer),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

enum DcBadgeTone { success, warning, danger, info, teal }

class DcCard extends StatelessWidget {
  const DcCard({super.key, required this.child, this.padding, this.onTap, this.color});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final body = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? DcColors.surfaceLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
    if (onTap == null) return body;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: body,
      ),
    );
  }
}

class DcSectionHeader extends StatelessWidget {
  const DcSectionHeader(this.title, {super.key, this.subtitle, this.action, this.onAction});

  final String title;
  final String? subtitle;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              if (subtitle != null)
                Text(subtitle!, style: const TextStyle(color: DcColors.onSurfaceVariant, fontSize: 13)),
            ],
          ),
        ),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
      ],
    );
  }
}

class DcEmpty extends StatelessWidget {
  const DcEmpty({super.key, required this.message, this.cta, this.onCta});

  final String message;
  final String? cta;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(message, textAlign: TextAlign.center, style: const TextStyle(color: DcColors.onSurfaceVariant)),
          if (cta != null) ...[
            const SizedBox(height: 12),
            FilledButton(onPressed: onCta, child: Text(cta!)),
          ],
        ],
      ),
    );
  }
}

DcBadgeTone statusTone(String status) {
  final s = status.toLowerCase();
  if (s.contains('approved') || s.contains('ready') || s.contains('delivered') || s.contains('online')) {
    return DcBadgeTone.success;
  }
  if (s.contains('review') || s.contains('await') || s.contains('watch') || s.contains('due')) {
    return DcBadgeTone.warning;
  }
  if (s.contains('action') || s.contains('cancel') || s.contains('out') || s.contains('urgent')) {
    return DcBadgeTone.danger;
  }
  if (s.contains('consult') || s.contains('appoint')) return DcBadgeTone.info;
  return DcBadgeTone.teal;
}
