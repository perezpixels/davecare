import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets.dart';
import '../../data/mock_store.dart';
import '../../state/session.dart';
import '../../theme/davecare_theme.dart';

String pharmacyBase(BuildContext context) {
  final path = GoRouterState.of(context).uri.path;
  if (path.startsWith('/manager')) return '/manager';
  if (path.startsWith('/staff')) return '/staff';
  return '/pharmacist';
}

class _NavItem {
  const _NavItem(this.path, this.label, this.icon, {this.badge, this.managerOnly = false});
  final String path;
  final String label;
  final IconData icon;
  final String? badge;
  final bool managerOnly;
}

class PharmacyShell extends ConsumerWidget {
  const PharmacyShell({super.key, required this.child, required this.workspace});

  final Widget child;
  final AppRole workspace;

  List<_NavItem> _items(String base) {
    final clinical = [
      _NavItem(base, 'Dashboard & Actions', Icons.grid_view),
      _NavItem('$base/prescriptions', 'Prescriptions', Icons.receipt_long, badge: '7'),
      _NavItem('$base/consultations', 'Consultations', Icons.forum, badge: '3'),
      _NavItem('$base/follow-ups', 'Follow-ups', Icons.support_agent, badge: '5'),
      _NavItem('$base/appointments', 'Appointments', Icons.calendar_month),
    ];
    final patients = [
      _NavItem('$base/customers', 'Customers 360', Icons.badge),
      _NavItem('$base/demand', 'Demand & Watchlist', Icons.visibility, badge: '24 waiting', managerOnly: true),
      _NavItem('$base/orders', 'Orders & Dispensing', Icons.medication, badge: '28'),
    ];
    final ops = [
      _NavItem('$base/catalogue', 'Catalogue & Stock', Icons.inventory_2, managerOnly: true),
      _NavItem('$base/reports', 'Reports & Analytics', Icons.insights, managerOnly: true),
      _NavItem('$base/integrations', 'POS & MoMo Sync', Icons.sync_alt, managerOnly: true),
      _NavItem('$base/settings', 'Staff & Settings', Icons.settings, managerOnly: true),
    ];
    final allowOps = workspace == AppRole.manager;
    return [
      ...clinical,
      ...patients.where((i) => allowOps || !i.managerOnly),
      if (allowOps) ...ops,
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wide = MediaQuery.sizeOf(context).width >= 1024;
    final base = pharmacyBase(context);
    final loc = GoRouterState.of(context).uri.path;
    final items = _items(base);
    final roleLabel = switch (workspace) {
      AppRole.manager => 'Pharmacy Manager',
      AppRole.staff => 'Dispensing Staff',
      _ => 'Superintendent Pharmacist',
    };

    Widget section(String title) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 16, 6),
          child: Text(title, style: const TextStyle(fontSize: 11, letterSpacing: 0.8, color: DcColors.onSurfaceVariant, fontWeight: FontWeight.w700)),
        );

    final staffItems = [
      _NavItem(base, 'Orders & Dispensing', Icons.medication, badge: '28'),
      _NavItem('$base/prescriptions', 'Script pickup', Icons.receipt_long, badge: '7'),
      _NavItem('$base/customers', 'Customers', Icons.badge),
    ];

    final nav = ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DavidCare', style: TextStyle(color: DcColors.primary, fontWeight: FontWeight.w800, fontSize: 20)),
              const Text('Pharmacy Platform', style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
              const SizedBox(height: 12),
              DcCard(
                color: DcColors.surfaceLow,
                padding: const EdgeInsets.all(12),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('East Legon Branch', style: TextStyle(fontWeight: FontWeight.w700)),
                    Text('Accra, Ghana • GD-183-4921', style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: DcColors.secondaryContainer, borderRadius: BorderRadius.circular(999)),
                child: Text('ROLE  $roleLabel', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: DcColors.primary)),
              ),
            ],
          ),
        ),
        if (workspace == AppRole.staff) ...[
          section('DISPENSARY FLOOR'),
          ...staffItems.map((it) => _tile(context, loc, it)),
        ] else ...[
          section('CLINICAL CARE'),
          ...items.take(5).map((it) => _tile(context, loc, it)),
          section('PATIENTS & DEMAND'),
          ...items.skip(5).where((i) => !i.managerOnly || workspace == AppRole.manager).take(workspace == AppRole.manager ? 3 : 2).map((it) => _tile(context, loc, it)),
          if (workspace == AppRole.manager) ...[
            section('PHARMACY OPS & INSIGHTS'),
            ...items.where((i) => i.managerOnly && (i.path.contains('catalogue') || i.path.contains('reports') || i.path.contains('integrations') || i.path.contains('settings'))).map((it) => _tile(context, loc, it)),
          ],
        ],
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.all(16),
          child: DcBadge(label: 'Ghana FDA Regulated  •  v1.0', tone: DcBadgeTone.success),
        ),
      ],
    );

    final header = AppBar(
      title: const TextField(
        decoration: InputDecoration(
          hintText: 'Search patient by name, Ghana card, phone 024...',
          prefixIcon: Icon(Icons.search),
          filled: true,
        ),
      ),
      actions: [
        if (wide) const Padding(padding: EdgeInsets.only(right: 8), child: DcBadge(label: 'Connected to MedSys POS • Online', tone: DcBadgeTone.success)),
        TextButton.icon(onPressed: () => context.go('$base/prescriptions'), icon: const Icon(Icons.upload_file), label: const Text('+ Upload Rx')),
        TextButton.icon(onPressed: () => context.go('$base/consultations'), icon: const Icon(Icons.chat), label: const Text('+ Quick Consult')),
        const CircleAvatar(radius: 16, child: Text('DM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800))),
        IconButton(
          onPressed: () {
            ref.read(sessionProvider.notifier).logout();
            context.go(switch (workspace) {
              AppRole.manager => '/login/manager',
              AppRole.staff => '/login/staff',
              _ => '/login/pharmacist',
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );

    if (!wide) {
      return Scaffold(appBar: header, drawer: Drawer(child: nav), body: child);
    }
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 288, child: Material(color: DcColors.surfaceLowest, child: nav)),
          const VerticalDivider(width: 1),
          Expanded(child: Scaffold(appBar: header, body: child)),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, String loc, _NavItem it) {
    final selected = loc == it.path || (it.path != pharmacyBase(context) && loc.startsWith(it.path));
    return ListTile(
      selected: selected,
      selectedTileColor: DcColors.primaryContainer,
      selectedColor: DcColors.onPrimaryContainer,
      leading: Icon(it.icon, size: 20),
      title: Text(it.label, style: TextStyle(fontWeight: selected ? FontWeight.w700 : FontWeight.w500, fontSize: 14)),
      trailing: it.badge == null
          ? null
          : DcBadge(label: it.badge!, tone: it.badge!.contains('waiting') ? DcBadgeTone.warning : DcBadgeTone.teal),
      onTap: () => context.go(it.path),
    );
  }
}

class PharmacyDashboard extends StatelessWidget {
  const PharmacyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final base = pharmacyBase(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            DcBadge(label: 'SUPERINTENDENT SHIFT', tone: DcBadgeTone.teal),
            DcBadge(label: 'East Legon Flagship GD-183-4921', tone: DcBadgeTone.info),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Good morning, ${MockStore.pharmacistName.split(' ').take(3).join(' ')}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: DcColors.primary),
        ),
        const Text(
          'Clinical queue is steady. 7 urgent scripts awaiting validation before noon courier dispatch. Temperature log: Med-Fridge 4.2°C (Optimal).',
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _Kpi('ACTIVE CUSTOMERS', '1,248', '210 recurring refills locked'),
            _Kpi('PRESCRIPTIONS PENDING', '7', '3 Urgent  •  Target sign-off < 20m', alert: true),
            _Kpi('DIGITAL ORDERS TO DISPENSE', '28', '12 ready pickup  •  6 on dispatch'),
            _Kpi('ACTIVE CONSULTATIONS', '7', 'Mean response: 4m 12s'),
            _Kpi('FOLLOW-UPS DUE TODAY', '5', 'Post antibiotic & BP reviews'),
          ],
        ),
        const SizedBox(height: 24),
        const Text('ACTION CENTER: NEEDS IMMEDIATE ATTENTION', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.4)),
        const SizedBox(height: 8),
        _action(
          context,
          name: 'Ama Mensah',
          tag: 'High Urgency',
          body: 'Amoxicillin 500mg Capsules (21 caps) — Acute severe sore throat / Tonsillitis. Uploaded 12m ago.',
          cta: 'Review Prescription',
          to: '$base/prescriptions/rx1',
        ),
        _action(
          context,
          name: 'Kwame Asante',
          tag: 'Refill Overdue',
          body: 'Amlodipine 5mg Daily + Losartan 50mg. 32 days since 30-day regimen.',
          cta: 'WhatsApp Refill Reminder',
          to: '$base/follow-ups',
        ),
        _action(
          context,
          name: 'Akosua Boateng',
          tag: 'Side Effect Inquiry',
          body: 'Started feeling mild stomach discomfort after the 2:00 PM Erythromycin dose. Should I take it with milk?',
          cta: 'Open Consult Chat',
          to: '$base/consultations',
        ),
        _action(
          context,
          name: 'Kofi Mensah',
          tag: 'MoMo Paid GH₵145.00',
          body: 'Pickup: East Legon Counter. Metformin 500mg SR (60s) + Glimipizide 2mg.',
          cta: 'Verify & Dispense',
          to: '$base/orders',
        ),
        _action(
          context,
          name: '24 Patients Watchlist Alert',
          tag: 'Stock-Out Demand',
          body: 'Augmentin 625mg (GSK Original) — 16 patients agreed to generic substitution upon restock.',
          cta: 'View Demand Group',
          to: '$base/demand',
        ),
      ],
    );
  }

  static Widget _action(
    BuildContext context, {
    required String name,
    required String tag,
    required String body,
    required String cta,
    required String to,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DcCard(
        onTap: () => context.go(to),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(width: 8),
                      DcBadge(label: tag, tone: statusTone(tag)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(body, style: const TextStyle(color: DcColors.onSurfaceVariant, fontSize: 13)),
                ],
              ),
            ),
            FilledButton(onPressed: () => context.go(to), child: Text(cta)),
          ],
        ),
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi(this.label, this.value, this.hint, {this.alert = false});
  final String label;
  final String value;
  final String hint;
  final bool alert;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: DcCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, letterSpacing: 0.5, color: DcColors.onSurfaceVariant, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: alert ? DcColors.error : DcColors.onSurface)),
            Text(hint, style: const TextStyle(color: DcColors.secondary, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class PharmacyPrescriptions extends StatelessWidget {
  const PharmacyPrescriptions({super.key});

  @override
  Widget build(BuildContext context) {
    final base = pharmacyBase(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const DcSectionHeader('Prescription clinical review', subtitle: 'AI may assist. Pharmacist decides. Never auto-approve.'),
        ...MockStore.prescriptions.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: DcCard(
              onTap: () => context.go('$base/prescriptions/${p.id}'),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('${p.customer} • ${p.title}'),
                subtitle: Text('${p.uploadedAt} • ${p.items.join(', ')}'),
                trailing: DcBadge(label: p.status.replaceAll('_', ' '), tone: statusTone(p.status)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PharmacyPrescriptionReview extends StatelessWidget {
  const PharmacyPrescriptionReview({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final p = MockStore.prescriptions.firstWhere((e) => e.id == id, orElse: () => MockStore.prescriptions.first);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(p.customer, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: DcColors.primary)),
        Text(p.title),
        const SizedBox(height: 12),
        ...p.items.map((i) => ListTile(leading: const Icon(Icons.medication), title: Text(i))),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            FilledButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Approved. Customer notified. Audit event recorded (UI mock).')),
              ),
              child: const Text('Approve'),
            ),
            OutlinedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Clarification requested. Customer notified.')),
              ),
              child: const Text('Request clarification'),
            ),
            OutlinedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Marked partially available.')),
              ),
              child: const Text('Partially available'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('AI may assist later. AI cannot make the final approval decision.', style: TextStyle(color: DcColors.onSurfaceVariant)),
      ],
    );
  }
}

class PharmacyConsultations extends StatelessWidget {
  const PharmacyConsultations({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const DcSectionHeader('Consultation follow-up workspace', subtitle: 'Structured pharmacy-care channel — not social chat.'),
        ...MockStore.consultations.map(
          (c) => DcCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('${c.customer} • ${c.subject}', style: const TextStyle(fontWeight: FontWeight.w800))),
                    DcBadge(label: c.status.replaceAll('_', ' '), tone: statusTone(c.status)),
                  ],
                ),
                const SizedBox(height: 8),
                ...c.messages.map((m) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text('${m.sender}: ${m.body}', style: const TextStyle(fontSize: 13)),
                    )),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reply sent. Customer notified.')),
                    ),
                    child: const Text('Reply'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PharmacyFollowUps extends StatelessWidget {
  const PharmacyFollowUps({super.key});

  @override
  Widget build(BuildContext context) {
    const rows = [
      ('Kwame Asante', 'Refill check-in', 'Due today', 'Amlodipine 5mg 30-day pack overdue'),
      ('Ama Mensah', 'Antibiotic course', 'Due today', 'Confirm Day 7 completion of Amoxicillin'),
      ('Akosua Boateng', 'Consultation follow-up', 'Due today', 'Stomach discomfort after erythromycin'),
    ];
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const DcSectionHeader('Follow-ups due'),
        ...rows.map(
          (r) => DcCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('${r.$1} • ${r.$2}', style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(r.$4),
              trailing: DcBadge(label: r.$3, tone: DcBadgeTone.warning),
            ),
          ),
        ),
      ],
    );
  }
}

class PharmacyAppointments extends StatelessWidget {
  const PharmacyAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        DcSectionHeader('Appointments'),
        DcCard(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Ama Mensah — Medication Adherence & BP Review'),
            subtitle: Text('Wed 25 Oct • 10:00–10:30 • East Legon Consultation Room 1'),
            trailing: DcBadge(label: 'Confirmed', tone: DcBadgeTone.success),
          ),
        ),
      ],
    );
  }
}

class PharmacyCustomers extends StatelessWidget {
  const PharmacyCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    final base = pharmacyBase(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const DcSectionHeader('Customers 360'),
        ...MockStore.customers.map(
          (c) => DcCard(
            onTap: () => context.go('$base/customers/${Uri.encodeComponent(c.name)}'),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${c.phone} • ${c.area}'),
              trailing: DcBadge(label: 'NHIS ${c.nhis}', tone: DcBadgeTone.teal),
            ),
          ),
        ),
      ],
    );
  }
}

class PharmacyCustomer360 extends StatelessWidget {
  const PharmacyCustomer360({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final c = MockStore.customers.firstWhere((e) => e.name == name, orElse: () => MockStore.customers.first);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(c.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: DcColors.primary)),
        Text('${c.phone} • ${c.area} • NHIS ${c.nhis}'),
        const SizedBox(height: 16),
        DcCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Medications', style: TextStyle(fontWeight: FontWeight.w700)),
              ...c.medications.map((m) => Text('• $m')),
            ],
          ),
        ),
        DcCard(child: Text(c.notes)),
        const DcSectionHeader('Timeline'),
        ...MockStore.timeline.map((e) => ListTile(title: Text(e.title), subtitle: Text(e.detail), trailing: Text(e.when))),
      ],
    );
  }
}

class PharmacyOrders extends StatelessWidget {
  const PharmacyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const DcSectionHeader('Orders & dispensing hub', subtitle: 'Customer-facing digital orders — not POS transactions.'),
        ...MockStore.orders.map(
          (o) => DcCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('${o.number} • ${o.itemsLabel}'),
              subtitle: Text(o.fulfillment),
              trailing: FilledButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${o.number} marked ready'))),
                child: const Text('Update status'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PharmacyDemand extends StatelessWidget {
  const PharmacyDemand({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const DcSectionHeader('Customer demand', subtitle: 'Customers are asking for this. Not an inventory ledger.'),
        Text('Unmet demand captured ${formatGhs(5180)}', style: const TextStyle(fontWeight: FontWeight.w800, color: DcColors.primary, fontSize: 22)),
        const SizedBox(height: 12),
        ...MockStore.demand.map(
          (d) => DcCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(d.product, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${d.waiters} patients waiting'),
              trailing: Text(formatGhs(d.valueGhs), style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      ],
    );
  }
}

class PharmacySimplePage extends StatelessWidget {
  const PharmacySimplePage({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        DcSectionHeader(title),
        DcCard(child: Text(body)),
      ],
    );
  }
}
