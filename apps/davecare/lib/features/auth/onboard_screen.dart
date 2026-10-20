import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../state/session.dart';
import '../../theme/davecare_theme.dart';

enum _OnboardTab { login, signup }

class OnboardScreen extends ConsumerStatefulWidget {
  const OnboardScreen({super.key});

  @override
  ConsumerState<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends ConsumerState<OnboardScreen> {
  _OnboardTab _tab = _OnboardTab.login;
  AppRole _role = AppRole.pharmacist;
  final _pharmacy = TextEditingController(text: 'East Legon Hub');
  final _phone = TextEditingController(text: '024 410 8410');
  final _name = TextEditingController(text: 'Pharm. David Mensah');

  @override
  void dispose() {
    _pharmacy.dispose();
    _phone.dispose();
    _name.dispose();
    super.dispose();
  }

  void _applyRoleDefaults(AppRole role) {
    _role = role;
    _phone.text = switch (role) {
      AppRole.pharmacist => '024 410 8410',
      AppRole.manager => '024 220 0190',
      AppRole.staff => '024 310 7710',
      _ => _phone.text,
    };
    _name.text = switch (role) {
      AppRole.pharmacist => 'Pharm. David Mensah',
      AppRole.manager => 'Ama Mensah',
      AppRole.staff => 'Kojo Asante',
      _ => _name.text,
    };
  }

  LoginGateway get _gateway => switch (_role) {
        AppRole.manager => LoginGateway.manager,
        AppRole.staff => LoginGateway.staff,
        _ => LoginGateway.pharmacist,
      };

  void _continue() {
    if (_tab == _OnboardTab.login) {
      context.go(switch (_gateway) {
        LoginGateway.manager => '/login/manager',
        LoginGateway.staff => '/login/staff',
        _ => '/login/pharmacist',
      });
      return;
    }
    ref.read(sessionProvider.notifier).setPhone(_phone.text);
    ref.read(sessionProvider.notifier).login(_role);
    context.go(switch (_role) {
      AppRole.manager => '/manager',
      AppRole.staff => '/staff',
      _ => '/pharmacist',
    });
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 960;
    return Scaffold(
      backgroundColor: DcColors.background,
      body: Column(
        children: [
          Material(
            color: DcColors.surfaceLowest.withValues(alpha: 0.92),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 20, vertical: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 4),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('DavidCare', style: TextStyle(color: DcColors.primary, fontWeight: FontWeight.w800, fontSize: 20, height: 1)),
                        Text('GHANA & WEST AFRICA', style: TextStyle(color: DcColors.secondary, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                      ],
                    ),
                    const Spacer(),
                    TextButton(onPressed: () => context.go('/login'), child: const Text('Patient app')),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(wide ? 48 : 20, 24, wide ? 48 : 20, 40),
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 880),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PHARMACY ONBOARDING', style: TextStyle(color: DcColors.secondary, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                        const SizedBox(height: 8),
                        Text(
                          _tab == _OnboardTab.login ? 'Log in to your pharmacy workspace.' : 'Create a pharmacy workspace.',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: DcColors.primary, height: 1.15),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Choose your role, then continue to an isolated gateway. Pharmacist, manager, and dispensing staff do not share a session.',
                          style: TextStyle(color: DcColors.onSurfaceVariant, height: 1.45),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: DcColors.surfaceLow, borderRadius: BorderRadius.circular(999)),
                          child: Row(
                            children: [
                              _tabChip('Log in', _OnboardTab.login),
                              _tabChip('Sign up', _OnboardTab.signup),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _roleCard(
                              role: AppRole.pharmacist,
                              title: 'Pharmacist',
                              body: 'Clinical Action Center, Rx review, Ask Pharm. David. Never auto-approve.',
                              icon: Icons.medical_services_outlined,
                            ),
                            _roleCard(
                              role: AppRole.manager,
                              title: 'Manager',
                              body: 'Demand watchlists, catalogue, staff, and branch ops. Not a POS.',
                              icon: Icons.storefront_outlined,
                            ),
                            _roleCard(
                              role: AppRole.staff,
                              title: 'Dispensing staff',
                              body: 'Orders, pickup PINs, and counter dispensing from the staff hub.',
                              icon: Icons.medication_outlined,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (_tab == _OnboardTab.signup) ...[
                          _field('Full name', _name),
                          const SizedBox(height: 12),
                          _field('Pharmacy name', _pharmacy),
                          const SizedBox(height: 12),
                        ],
                        _field('Ghana phone (MTN / Telecel / AT)', _phone),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _continue,
                            child: Text(_tab == _OnboardTab.login ? 'Continue to secure login' : 'Create workspace & enter dashboard'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _tab == _OnboardTab.login
                              ? 'You will confirm a one-time code on the isolated ${switch (_role) {
                                  AppRole.manager => 'manager',
                                  AppRole.staff => 'staff',
                                  _ => 'pharmacist',
                                }} gateway.'
                              : 'Pilot sign-up creates an East Legon Hub workspace immediately. OTP and tenant APIs attach in the Laravel phase.',
                          style: const TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabChip(String label, _OnboardTab tab) {
    final on = _tab == tab;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => setState(() => _tab = tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: on ? DcColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: on ? Colors.white : DcColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required AppRole role,
    required String title,
    required String body,
    required IconData icon,
  }) {
    final on = _role == role;
    return SizedBox(
      width: 270,
      child: Material(
        color: on ? DcColors.primary : DcColors.surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _applyRoleDefaults(role)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: on ? Colors.white : DcColors.primaryContainer),
                const SizedBox(height: 12),
                Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: on ? Colors.white : DcColors.onSurface)),
                const SizedBox(height: 6),
                Text(body, style: TextStyle(fontSize: 13, height: 1.35, color: on ? const Color(0xFF8DD0BD) : DcColors.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontSize: 11, letterSpacing: 0.6, fontWeight: FontWeight.w700, color: DcColors.onSurfaceVariant)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: DcColors.surfaceLow,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
