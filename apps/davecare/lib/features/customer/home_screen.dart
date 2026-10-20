import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_store.dart';
import '../../state/session.dart';
import '../../theme/davecare_theme.dart';
import 'stitch_chrome.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const StitchHeader(title: 'Home Feed', online: true),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('DAVIDCARE FAMILY',
                                style: TextStyle(color: DcColors.secondary, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                            SizedBox(width: 6),
                            Pill('NHIS Linked'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('Good morning, Ama 👋', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.15)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: DcColors.secondaryContainer,
                    child: const Text('AM', style: TextStyle(fontWeight: FontWeight.w800, color: DcColors.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SoftCard(
                color: DcColors.surfaceLow,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(Icons.storefront, color: DcColors.secondary),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DavidCare Pharmacy • Osu Oxford St, Accra',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('Open until 9:00 PM • 1.2 km away',
                              style: TextStyle(color: DcColors.secondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: DcColors.secondary),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                onTap: () => context.go('/shop'),
                decoration: InputDecoration(
                  hintText: 'Search medicines, symptoms, or OTC...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.05,
                children: [
                  _Tile(
                    filled: true,
                    title: 'Upload Rx',
                    subtitle: 'Quick review in 15m',
                    badge: 'Fast Track',
                    icon: Icons.document_scanner,
                    onTap: () => context.go('/health/prescriptions'),
                  ),
                  _Tile(
                    title: 'Ask Pharm. David',
                    subtitle: 'Free clinical counsel',
                    badge: 'Online now',
                    icon: Icons.chat_bubble_outline,
                    onTap: () => context.go('/health/consultations'),
                  ),
                  _Tile(
                    title: 'My Regimens',
                    subtitle: '1 dose pending',
                    icon: Icons.medication,
                    onTap: () => context.go('/health/timeline'),
                  ),
                  _Tile(
                    title: 'Book Visit',
                    subtitle: 'BP, sugar & wellness',
                    icon: Icons.calendar_today,
                    onTap: () => context.go('/health/appointments'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Pill('Active Course'),
                        SizedBox(width: 8),
                        Text('Day 3 of 7', style: TextStyle(color: DcColors.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('Amoxicillin 500mg', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const Text('1 capsule • 3 times daily (after meals)',
                        style: TextStyle(color: DcColors.onSurfaceVariant, fontSize: 13)),
                    const SizedBox(height: 10),
                    const Text("TODAY'S SCHEDULE",
                        style: TextStyle(fontSize: 11, letterSpacing: 0.5, color: DcColors.onSurfaceVariant, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Expanded(child: _Dose('8:00 AM', 'Taken', done: true)),
                        SizedBox(width: 6),
                        Expanded(child: _Dose('2:00 PM', 'After lunch', active: true)),
                        SizedBox(width: 6),
                        Expanded(child: _Dose('8:00 PM', 'Tonight')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(onPressed: () {}, child: const Text('Mark as Taken')),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(onPressed: () {}, child: const Text('Snooze 15m')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SoftCard(
                onTap: () => context.go('/orders/o1'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Order #DC-1042', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        ),
                        Pill('Ready for Pickup', bg: DcColors.successBg, fg: DcColors.successFg),
                      ],
                    ),
                    const Text('2 items • MoMo Paid GH₵115.00', style: TextStyle(color: DcColors.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    const Text('Counter B • Osu Oxford Street Hub  PIN: 4892', style: TextStyle(fontSize: 13)),
                    const SizedBox(height: 8),
                    const Text('View Pickup Code & Route',
                        style: TextStyle(color: DcColors.primary, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SoftCard(
                color: DcColors.surfaceHigh,
                onTap: () => context.go('/health/consultations/c1'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: DcColors.secondaryContainer,
                          child: Text('DM', style: TextStyle(fontWeight: FontWeight.w700, color: DcColors.primary)),
                        ),
                        SizedBox(width: 8),
                        Expanded(child: Text('Pharm. David Mensah', style: TextStyle(fontWeight: FontWeight.w700))),
                        Text('10m ago', style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      MockStore.consultations.first.messages.last.body,
                      style: const TextStyle(color: DcColors.onSurfaceVariant, height: 1.4),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        FilledButton.tonal(onPressed: () => context.go('/health/consultations/c1'), child: const Text('Reply to Pharm. David')),
                        const SizedBox(width: 8),
                        OutlinedButton(onPressed: () {}, child: const Text('Understood')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Regulars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                        Text('Quick 1-tap refill from your verified history',
                            style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () => context.go('/health/refills'), child: const Text('History')),
                ],
              ),
              SizedBox(
                height: 188,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: MockStore.products.take(3).map((p) {
                    return Container(
                      width: 168,
                      margin: const EdgeInsets.only(right: 8),
                      child: SoftCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Pill(p.boughtTimes != null ? 'Bought ${p.boughtTimes}x' : 'Refill Ready'),
                            const SizedBox(height: 8),
                            Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                            Text(p.detail, style: const TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                            const Spacer(),
                            Text(formatGhs(p.priceGhs),
                                style: const TextStyle(color: DcColors.primary, fontWeight: FontWeight.w800, fontSize: 18)),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  ref.read(sessionProvider.notifier).addToCart(p.id);
                                  context.go('/checkout');
                                },
                                child: const Text('Order Again'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              SoftCard(
                color: DcColors.surfaceLow,
                child: Row(
                  children: const [
                    CircleAvatar(backgroundColor: DcColors.errorContainer, child: Icon(Icons.local_hospital, color: DcColors.error)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Urgent Prescription Need?', style: TextStyle(fontWeight: FontWeight.w700)),
                          Text('DavidCare 24/7 Dispatch Desk: +233 (0)24 498 0122',
                              style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    Icon(Icons.call, color: DcColors.secondary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Dose extends StatelessWidget {
  const _Dose(this.time, this.label, {this.done = false, this.active = false});
  final String time;
  final String label;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: active ? DcColors.primaryContainer : DcColors.surfaceLow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(done ? Icons.check_circle : Icons.schedule, size: 16, color: active ? Colors.white : DcColors.secondary),
          const SizedBox(height: 4),
          Text(time, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: active ? Colors.white : DcColors.onSurface)),
          Text(label, style: TextStyle(fontSize: 10, color: active ? Colors.white70 : DcColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.filled = false,
    this.badge,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      color: filled ? DcColors.primary : Colors.white,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: filled ? Colors.white : DcColors.primary),
              const Spacer(),
              if (badge != null)
                Pill(badge!, bg: filled ? DcColors.secondaryContainer : DcColors.successBg, fg: filled ? DcColors.primary : DcColors.successFg),
            ],
          ),
          const Spacer(),
          Text(title, style: TextStyle(color: filled ? Colors.white : DcColors.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
          Text(subtitle, style: TextStyle(color: filled ? Colors.white70 : DcColors.onSurfaceVariant, fontSize: 12)),
        ],
      ),
    );
  }
}
