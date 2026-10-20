import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_store.dart';
import '../../state/session.dart';
import '../../theme/davecare_theme.dart';
import 'stitch_chrome.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  var _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final watched = ref.watch(sessionProvider).watched;
    return ListView(
      children: [
        const StitchHeader(title: 'Shop'),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Amoxicillin',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: ['All', 'Prescription', 'OTC', 'Chronic Care'].map((f) {
                  final on = _filter == f;
                  return ChoiceChip(
                    label: Text(f),
                    selected: on,
                    onSelected: (_) => setState(() => _filter = f),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text('Dispatching from East Legon Hub', style: TextStyle(fontWeight: FontWeight.w600)),
              const Text('Express delivery within 45 mins in GA-492-…',
                  style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
              const SizedBox(height: 12),
              SoftCard(
                color: const Color(0xFFF3E8FF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Pill('WATCHLIST ACTIVE', bg: Color(0xFFE9D5FF), fg: Color(0xFF6B21A8)),
                    const SizedBox(height: 8),
                    const Text('Augmentin 625mg', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                    const Text('Amoxicillin / Clavulanic Acid • GSK', style: TextStyle(color: DcColors.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    const Pill('Currently Unavailable at East Legon Hub', bg: DcColors.errorContainer, fg: DcColors.error),
                    const SizedBox(height: 8),
                    const Text("We'll automatically alert you via WhatsApp / SMS the moment our team confirms wholesale supplier restock in Accra."),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () => ref.read(sessionProvider.notifier).toggleWatch('p5'),
                      child: Text(watched.contains('p5') ? 'Watching Product (1-Tap Unwatch)' : 'Notify me when available'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SoftCard(
                color: DcColors.primaryContainer,
                onTap: () => context.go('/health/consultations'),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Need an alternative?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                    Text('Chat directly with Pharm. David for equivalent generic formulations.',
                        style: TextStyle(color: Color(0xFF8DD0BD))),
                    SizedBox(height: 8),
                    Text('Chat with Pharm. David →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Matching Medicines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _medCard(
                name: 'Amoxicillin 500mg',
                meta: 'Capsules (Medreich) • 21 caps',
                price: 45,
                badge: 'Prescription Required',
                stock: 'In Stock • East Legon Hub',
                actions: [
                  ('Upload Rx to Order', () => context.go('/health/prescriptions')),
                  ('Ask Pharm. David', () => context.go('/health/consultations')),
                ],
              ),
              _medCard(
                name: 'Paracetamol Extra',
                meta: '500mg/65mg Caffeine • Pack of 20',
                price: 18,
                badge: 'Over-The-Counter (OTC)',
                stock: 'In Stock • 38 available',
                actions: [
                  ('Add to Order', () {
                    ref.read(sessionProvider.notifier).addToCart('p1');
                    context.go('/checkout');
                  }),
                ],
              ),
              _medCard(
                name: 'Ventolin Evohaler',
                meta: 'Salbutamol 100mcg • 200 actuations',
                price: 85,
                badge: 'Low Availability (2 left)',
                stock: 'Prescription verification strictly enforced',
                warning: true,
                actions: [
                  ('Reserve Unit with Rx', () => context.go('/health/prescriptions')),
                  ('Emergency Hold', () {}),
                ],
              ),
              const SizedBox(height: 8),
              const Text('ACCEPTED LOCAL PAYMENTS', style: TextStyle(fontSize: 11, letterSpacing: 0.6, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Expanded(child: SoftCard(child: Center(child: Text('MTN MoMo', style: TextStyle(fontWeight: FontWeight.w700))))),
                  SizedBox(width: 8),
                  Expanded(child: SoftCard(child: Center(child: Text('Telecel Cash', style: TextStyle(fontWeight: FontWeight.w700))))),
                  SizedBox(width: 8),
                  Expanded(child: SoftCard(child: Center(child: Text('AT Money', style: TextStyle(fontWeight: FontWeight.w700))))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _medCard({
    required String name,
    required String meta,
    required double price,
    required String badge,
    required String stock,
    required List<(String, VoidCallback)> actions,
    bool warning = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Pill(badge, bg: warning ? DcColors.warningBg : DcColors.infoBg, fg: warning ? DcColors.warningFg : DcColors.infoFg),
                const Spacer(),
                Text(formatGhs(price), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: DcColors.primary)),
              ],
            ),
            const SizedBox(height: 6),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            Text(meta, style: const TextStyle(color: DcColors.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 4),
            Text(stock, style: TextStyle(color: warning ? DcColors.warningFg : DcColors.secondary, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: actions
                  .map((a) => FilledButton(onPressed: a.$2, child: Text(a.$1)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Checkout & Payment', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Pill('Step 2 of 3 • Final Verification'),
                  const SizedBox(height: 8),
                  const Text('Review & Instant Pay', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                  const Text('Community prescription order ready for local fulfilment.',
                      style: TextStyle(color: DcColors.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  SoftCard(
                    color: DcColors.successBg,
                    child: Row(
                      children: const [
                        CircleAvatar(backgroundColor: Colors.white, child: Text('DM', style: TextStyle(fontWeight: FontWeight.w800, color: DcColors.primary))),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text('Pharm. David Mensah\nReviewed & certified • GPhC Reg #P-11082',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Medications in Bag (3)', style: TextStyle(fontWeight: FontWeight.w800)),
                  _line('Amoxicillin 500mg', '21 capsules • 1 cap tid × 7 days', 45, 'Approved for pickup'),
                  _line('Ibuprofen 400mg', '10 film-coated tablets', 35, null),
                  _line('Paracetamol Extra 500mg', 'Rapid relief caplets', 35, null),
                  const SizedBox(height: 12),
                  const Text('Fulfilment Method', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Expanded(child: SoftCard(color: DcColors.primaryContainer, child: Text('Counter Pickup\nFree • Instant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))),
                      SizedBox(width: 8),
                      Expanded(child: SoftCard(child: Text('Express Motorbike\nGH₵15.00 • 45 mins'))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('DavidCare Pharmacy • East Legon', style: TextStyle(fontWeight: FontWeight.w800)),
                        Text('Plot 14, Boundary Road, East Legon, Accra'),
                        SizedBox(height: 8),
                        Text('Pickup PIN Code', style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                        Text('4892', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 8, color: DcColors.primary)),
                        Text('Show this PIN at the counter to collect.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w800)),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Mobile Money  Instant', style: TextStyle(fontWeight: FontWeight.w800)),
                        Text('MTN MoMo • Telecel Cash • AT Money'),
                        SizedBox(height: 8),
                        Wrap(spacing: 6, children: [Pill('MTN MoMo'), Pill('Telecel Cash'), Pill('AT Money')]),
                        SizedBox(height: 8),
                        Text('Instant USSD prompt sent to 024 498 0122', style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SoftCard(child: Text('Debit / Credit Card\nVisa • Mastercard • Gh-Link')),
                  const SoftCard(child: Text('Cash at Counter\nPay in person upon collection')),
                  const SizedBox(height: 8),
                  const Row(children: [Text('Items Subtotal (3 medicines)'), Spacer(), Text('GH₵115.00')]),
                  const Row(children: [Text('Fulfilment Fee (Pickup)'), Spacer(), Text('GH₵0.00')]),
                  const Row(
                    children: [
                      Text('Total Payable', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      Spacer(),
                      Text('GH₵115.00', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: DcColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => context.go('/orders/o1'),
                    child: const Text('Pay GH₵115.00 with MTN MoMo'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Safe medication dispensing under Ghana FDA regulations • DavidCare Health',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: DcColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _line(String name, String detail, double price, String? status) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SoftCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(detail, style: const TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                  if (status != null) Pill(status, bg: DcColors.successBg, fg: DcColors.successFg),
                ],
              ),
            ),
            Text(formatGhs(price), style: const TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const StitchHeader(title: 'Live Tracker', subtitle: 'Order Status'),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SoftCard(
            onTap: () => context.go('/orders/o1'),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Pill('PICKUP PASS ACTIVE'),
                    Spacer(),
                    Pill('Counter B Ready', bg: DcColors.successBg, fg: DcColors.successFg),
                  ],
                ),
                SizedBox(height: 8),
                Text('Order #DC-1042', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                Text('3 Prescribed & OTC Items  •  GH₵115.00'),
                Text('MTN Mobile Money Verified', style: TextStyle(color: DcColors.secondary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Order Status Live Tracker', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [Pill('PICKUP PASS ACTIVE'), Spacer(), Pill('Counter B Ready', bg: DcColors.successBg, fg: DcColors.successFg)]),
                  const SizedBox(height: 8),
                  const Text('Order #DC-1042', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                  const Text('3 Prescribed & OTC Items  •  GH₵115.00'),
                  const SizedBox(height: 12),
                  SoftCard(
                    color: DcColors.primaryContainer,
                    child: Column(
                      children: const [
                        Text('COUNTER HANDOVER PASS', style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 0.8)),
                        Text('Show PIN to Pharmacist', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 8),
                        Text('4  8  9  2', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: 8)),
                        Text('Show this PIN to pharmacy staff at Counter B (East Legon Hub).',
                            textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF8DD0BD))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Dispensing Progress', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  const _Step(true, 'Order Placed & Rx Attached', '14:02'),
                  const _Step(true, 'Clinical Review by Pharm. David', '14:10'),
                  const _Step(true, 'Dispensed & Tamper Sealed', '14:18'),
                  const _Step(true, 'Ready for Counter Pickup', '14:26 (Now)'),
                  const _Step(false, 'Collected & Logged to Health Timeline', ''),
                  const SizedBox(height: 12),
                  const SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ASSIGNED PHARMACY HUB', style: TextStyle(fontSize: 11, letterSpacing: 0.5)),
                        Text('DavidCare Pharmacy Flagship', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                        Text('East Legon, Boundary Road, Accra'),
                        Text('1.4 km away (~6 min drive)'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: OutlinedButton(onPressed: () => context.go('/health/timeline'), child: const Text('Add to My Daily Medication Reminders'))),
                    ],
                  ),
                  TextButton(
                    onPressed: () => context.go('/health/consultations/c1'),
                    child: const Text('Ask Pharm. David about this Order'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.done, this.title, this.time);
  final bool done;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(done ? Icons.check_circle : Icons.radio_button_unchecked, color: done ? DcColors.secondary : DcColors.outline),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Text(time, style: const TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
    );
  }
}

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      ('My Medications', 'Daily dose, timeline, refill watch', '/health/timeline', Icons.timeline),
      ('Prescriptions', 'Upload wallet & pharmacist review', '/health/prescriptions', Icons.receipt_long),
      ('Smart refills', 'May be due based on purchase pattern', '/health/refills', Icons.autorenew),
      ('Consultations', 'Ask Pharm. David', '/health/consultations', Icons.forum),
      ('Appointments', 'Clinical care booking', '/health/appointments', Icons.event),
      ('Family', 'Dependents with explicit permissions', '/health/family', Icons.family_restroom),
    ];
    return ListView(
      children: [
        const StitchHeader(title: 'Health', online: true),
        ...tiles.map(
          (t) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SoftCard(
              onTap: () => context.go(t.$3),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(backgroundColor: DcColors.secondaryContainer, child: Icon(t.$4, color: DcColors.primary)),
                title: Text(t.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(t.$2),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Health Regimen', online: true, showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Patient: Ama Mensah', style: TextStyle(fontWeight: FontWeight.w700)),
                  const Text('Synced with DavidCare Pharmacy  •  Live Sync', style: TextStyle(fontSize: 12, color: DcColors.secondary)),
                  const SizedBox(height: 10),
                  SoftCard(
                    child: Row(
                      children: const [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("TODAY'S REGIMEN", style: TextStyle(fontSize: 11, letterSpacing: 0.5)),
                              Text('2 of 3 Doses Taken', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                              Text('Great adherence today, Ama! 1 afternoon antibiotic capsule due now.'),
                            ],
                          ),
                        ),
                        Text('66%\nToday', textAlign: TextAlign.center, style: TextStyle(color: DcColors.secondary, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    color: DcColors.successBg,
                    child: const Text('✓ Metformin 500mg  Morning\n1 tablet with warm breakfast\nTaken at 8:12 AM'),
                  ),
                  const SizedBox(height: 8),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Pill('DUE NOW', bg: DcColors.warningBg, fg: DcColors.warningFg),
                        const Text('Amoxicillin 500mg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                        const Text('1 Capsule • Take with water after lunch'),
                        const Text('Complete your 7-day course to prevent antibiotic resistance. Day 3 of 7.',
                            style: TextStyle(color: DcColors.onSurfaceVariant)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Snooze 30m'))),
                            const SizedBox(width: 8),
                            Expanded(child: FilledButton(onPressed: () {}, child: const Text('Mark as Taken'))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    color: DcColors.surfaceLow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('REFILL WATCH ALGORITHM', style: TextStyle(fontSize: 11, letterSpacing: 0.4)),
                        const Text('Refill Due in 4 Days', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                        const Text('This medication may be due for a refill based on your previous purchase pattern.'),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: () => context.go('/health/refills'),
                          child: const Text('Request Pharmacy Refill    GH₵55.00'),
                        ),
                        TextButton(
                          onPressed: () => context.go('/health/consultations'),
                          child: const Text('Ask Pharm. David a Question'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Prescription History', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  ...MockStore.timeline.map(
                    (e) => SoftCard(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text(e.detail),
                        trailing: Text(e.when, style: const TextStyle(fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Upload Prescription', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Prescription Services', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const Pill('MoH & FDA Regulated'),
                  const SizedBox(height: 8),
                  const SoftCard(
                    color: DcColors.surfaceLow,
                    child: Text(
                      'Certified Pharmacist Review: Every prescription is thoroughly inspected for correct dosage, cross-interactions, and authenticity prior to packaging and dispatch.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Upload New Prescription', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _up('Camera Scan', Icons.photo_camera),
                      const SizedBox(width: 8),
                      _up('Photo Gallery', Icons.image),
                      const SizedBox(width: 8),
                      _up('PDF Document', Icons.picture_as_pdf),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dr_Mensah_Clinic_Rx_Sept2…', style: TextStyle(fontWeight: FontWeight.w800)),
                        const Text('Uploaded today at 10:15 AM'),
                        const Pill('Under Review by Pharm. David Mensah', bg: DcColors.warningBg, fg: DcColors.warningFg),
                        const SizedBox(height: 8),
                        const Text('1. Submitted    2. Reviewing    3. Ready', style: TextStyle(fontSize: 12)),
                        LinearProgressIndicator(value: 0.55, color: DcColors.primary, backgroundColor: DcColors.surfaceLow),
                        const SizedBox(height: 6),
                        const Text('Average review time: ~8 minutes. You will receive an instant notification via SMS and WhatsApp.',
                            style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(child: Text('#DC-RX-1042', style: TextStyle(fontWeight: FontWeight.w800))),
                            Pill('Partially Dispensed', bg: DcColors.warningBg, fg: DcColors.warningFg),
                          ],
                        ),
                        const Text('Prescribed by Dr. K. Boateng – Ridge Hospital, Accra'),
                        const Text('• Amoxicillin 500mg (21 Caps)  Dispensed'),
                        const Text('• Ibuprofen 400mg (10 Tabs)  Dispensed'),
                        const Text('• Cough Expectorant  Notify when in stock'),
                        TextButton(onPressed: () => context.go('/health/timeline'), child: const Text('View Regimen →')),
                      ],
                    ),
                  ),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(child: Text('#DC-RX-0998', style: TextStyle(fontWeight: FontWeight.w800))),
                            Pill('Active Ongoing'),
                          ],
                        ),
                        const Text('Metformin 500mg (Glucophage)\nTake 1 tablet twice daily with meals'),
                        FilledButton(
                          onPressed: () => context.go('/health/refills'),
                          child: const Text('Order Refill (GH₵42.00)'),
                        ),
                      ],
                    ),
                  ),
                  SoftCard(
                    onTap: () => context.go('/health/consultations'),
                    child: const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(child: Text('DM')),
                      title: Text('Have questions about your dosage?'),
                      subtitle: Text('Chat with Pharm. David Mensah'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _up(String label, IconData icon) {
    return Expanded(
      child: SoftCard(
        child: Column(
          children: [
            Icon(icon, color: DcColors.primary),
            const SizedBox(height: 6),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class RefillsScreen extends StatelessWidget {
  const RefillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Refill', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SoftCard(
                    color: DcColors.successBg,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your medication may be due for a refill soon', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        Text(
                          'Based on your previous 30-day fulfilment on Sept 21, your supply is calculated to have approximately 4 days remaining.',
                        ),
                        Text('Respectful estimate based on your regular schedule.', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Pill('Refill Window Open'),
                        const Text('Amlodipine 5mg', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const Text('Daily Blood Pressure Support'),
                        const Text('Cadence: ~30 days  •  Last filled Aug 28'),
                        const SizedBox(height: 8),
                        const Text('GH₵55.00 for 30 days', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: DcColors.primary)),
                        FilledButton(onPressed: () => context.go('/checkout'), child: const Text('Request Pharmacy Refill (GH₵55.00)')),
                        TextButton(onPressed: () => context.go('/health/consultations'), child: const Text('Ask Pharm. David about dose adjustment')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConsultHubScreen extends StatelessWidget {
  const ConsultHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Consultation', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pharm. David Mensah', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const Text('Superintendent Pharmacist, East Legon'),
                  const Pill('Available now • Responds in 5–10 mins'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Direct Hotline'))),
                      const SizedBox(width: 8),
                      Expanded(child: FilledButton(onPressed: () => context.go('/health/appointments'), child: const Text('Book Clinical Visit'))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const SoftCard(
                    color: DcColors.errorContainer,
                    child: Text(
                      'EMERGENCY NOTICE: For severe pain, breathing distress, or acute emergencies, call the Ghana National Ambulance Service (193 / 112).',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Your Consultations', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  SoftCard(
                    onTap: () => context.go('/health/consultations/c1'),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Pill('Awaiting Pharmacist', bg: DcColors.warningBg, fg: DcColors.warningFg),
                        Text('Medication Question: Amoxicillin 500…', style: TextStyle(fontWeight: FontWeight.w700)),
                        Text('I felt mild stomach discomfort after my 2 PM dose. Should I take it with food?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('What can we help with today?', style: TextStyle(fontWeight: FontWeight.w800)),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      Pill('Medication Question'),
                      Pill('Side-Effect Concern'),
                      Pill('Refill Question'),
                      Pill('Prescription Clarification'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => context.go('/health/consultations/c1'),
                    child: const Text('Send to Pharm. David Mensah'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConsultThreadScreen extends StatelessWidget {
  const ConsultThreadScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: Column(
          children: [
            const StitchHeader(title: 'Live Consult Chat', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(child: Text('DM')),
                    title: Text('Pharm. David Mensah', style: TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('Available now • Responds within 5–10 mins'),
                  ),
                  SoftCard(
                    color: DcColors.primaryContainer,
                    child: const Text('ACTIVE REGIMEN CONTEXT\nAmoxicillin 500mg (Day 3 of 7)',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(color: DcColors.primaryContainer, borderRadius: BorderRadius.circular(16)),
                      child: const Text(
                        'Good morning Pharm. David, I feel a bit of stomach discomfort about an hour after taking my 2 PM Amoxicillin capsule. Should I stop taking it?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                      child: const Text(
                        'Hello Ama! Mild stomach upset can sometimes happen with Amoxicillin. Make sure you take it with a light meal. Please do not stop the course early as the infection could return.',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type message to Pharm. David',
                  suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.send, color: DcColors.primary)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Appointment', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pharm. David Mensah', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const Text('Your health journey is personal. Let’s review your routines together in comfort.'),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Pill('Confirmed — In-Person or Tele-Consult'),
                        Text('Medication Adherence & BP Review', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                        Text('Wednesday, Oct 25 • 10:00 AM – 10:30 AM'),
                        Text('DavidCare East Legon (Consultation Room 1)'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Book a Clinical Service', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                  _svc('Comprehensive Medication Review', 'GH₵0.00', 'Complimentary • 30 min'),
                  _svc('Blood Pressure & Cardiovascular Check', 'GH₵15.00', 'In-Clinic • 15 min'),
                  _svc('Blood Glucose & HbA1c Screen', 'GH₵25.00', 'Lab & Consult • 15 min'),
                  FilledButton(onPressed: () {}, child: const Text('Confirm Appointment (Oct 25, 10:00 AM)')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _svc(String name, String price, String meta) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SoftCard(
        child: Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                Text(meta, style: const TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
              ]),
            ),
            Text(price, style: const TextStyle(fontWeight: FontWeight.w800, color: DcColors.primary)),
          ],
        ),
      ),
    );
  }
}

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: DcColors.background,
        body: ListView(
          children: [
            const StitchHeader(title: 'Family Profiles', showBack: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Pill('VERIFIED GUARDIAN ACCOUNT'),
                  const Text('My Family & Dependents', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const Text(
                    'Manage verified prescriptions, medication timelines, and reminders for family members under your authorized care.',
                    style: TextStyle(color: DcColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Pill('Viewing Kojo’s Health Record  ACTIVE', bg: DcColors.primaryContainer, fg: Colors.white),
                        Text('Amoxicillin Oral Suspension', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                        Text('125mg / 5ml • 100ml bottle'),
                        Text('Give 5ml twice daily after breakfast & dinner for 5 days. Shake well before measuring.'),
                        SizedBox(height: 8),
                        Text('Caregiver Access Permissions', style: TextStyle(fontWeight: FontWeight.w700)),
                        Text('• View Pediatric Prescriptions & Refills'),
                        Text('• Receive WhatsApp Dose Reminders'),
                        Text('• Book In-Clinic Consultations'),
                        Text('Never assume family access means unrestricted health-data access.'),
                      ],
                    ),
                  ),
                  const SoftCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Mary Mensah  •  Mother'),
                      subtitle: Text('Amlodipine 5mg + Losartan 50mg • MoMo 1-Tap Refill Due in 6 Days'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const StitchHeader(title: 'Ama Mensah'),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SoftCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('024 498 0122'),
                  subtitle: Text('Osu • GA-492-1204 • Near Oxford St\nNHIS Linked'),
                ),
              ),
              SoftCard(
                onTap: () => context.go('/health/family'),
                child: const ListTile(contentPadding: EdgeInsets.zero, title: Text('Family / dependents'), trailing: Icon(Icons.chevron_right)),
              ),
              const SoftCard(
                child: ListTile(contentPadding: EdgeInsets.zero, title: Text('Privacy & notification preferences')),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  ref.read(sessionProvider.notifier).logout();
                  context.go('/login');
                },
                child: const Text('Log out'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
