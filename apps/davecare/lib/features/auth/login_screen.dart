import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../state/session.dart';
import '../../theme/davecare_theme.dart';
import '../customer/stitch_chrome.dart';
import '../customer/stitch_page.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, required this.gateway});

  final LoginGateway gateway;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _phone;
  final _digits = ['5', '8', '2', '4', '', ''];

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: switch (widget.gateway) {
      LoginGateway.customer => '024 498 0122',
      LoginGateway.pharmacist => '024 410 8410',
      LoginGateway.manager => '024 220 0190',
      LoginGateway.staff => '024 310 7710',
    });
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  AppRole get _role => switch (widget.gateway) {
        LoginGateway.customer => AppRole.customer,
        LoginGateway.pharmacist => AppRole.pharmacist,
        LoginGateway.manager => AppRole.manager,
        LoginGateway.staff => AppRole.staff,
      };

  @override
  Widget build(BuildContext context) {
    if (widget.gateway == LoginGateway.customer) {
      return const StitchPage(
        asset: 'assets/stitch_html/welcome.html',
        signInCustomer: true,
      );
    }
    final body = SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          StitchHeader(
            title: switch (widget.gateway) {
              LoginGateway.customer => 'Search & Medicine Directory',
              LoginGateway.pharmacist => 'Pharmacist clinical login',
              LoginGateway.manager => 'Pharmacy manager login',
              LoginGateway.staff => 'Dispensing staff login',
            },
            showBack: true,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Pill(switch (widget.gateway) {
                LoginGateway.customer => 'PHARMACY COUNCIL LICENSED',
                LoginGateway.pharmacist => 'SUPERINTENDENT PHARMACIST',
                LoginGateway.manager => 'PHARMACY MANAGER GATEWAY',
                LoginGateway.staff => 'DISPENSING STAFF GATEWAY',
              }),
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: DcColors.secondary, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              const Text('East Legon Hub Online', style: TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 12),
          SoftCard(
            color: DcColors.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.local_pharmacy, color: Colors.white70),
                const SizedBox(height: 8),
                Text(
                  switch (widget.gateway) {
                    LoginGateway.customer => 'Your pharmacy, always\nwithin reach.',
                    LoginGateway.pharmacist => 'Clinical care workspace.\nPharmacist decides.',
                    LoginGateway.manager => 'Operations, demand &\nstaff — not a POS.',
                    LoginGateway.staff => 'Counter dispensing &\npickup PINs.',
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, height: 1.15),
                ),
                const SizedBox(height: 8),
                Text(
                  switch (widget.gateway) {
                    LoginGateway.customer =>
                      'Manage your medicines, prescriptions, orders and verified pharmacy care from East Legon Hub in one place.',
                    LoginGateway.pharmacist =>
                      'Review prescriptions, answer consultations, and work the Action Center for East Legon Hub. This gateway cannot open the customer app or manager console.',
                    LoginGateway.manager =>
                      'Customer demand, catalogue, orders, staff and audit. This gateway cannot open the customer app or pharmacist clinical queue as another user.',
                    LoginGateway.staff =>
                      'Prepare orders, confirm pickup PINs, and dispense from the East Legon counter. Clinical approval stays with the pharmacist.',
                  },
                  style: const TextStyle(color: Color(0xFF8DD0BD), fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            color: DcColors.surfaceLow,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: DcColors.secondaryContainer,
                  child: Text('DM', style: TextStyle(fontWeight: FontWeight.w700, color: DcColors.primary)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        switch (widget.gateway) {
                          LoginGateway.manager => 'Ama Mensah  •  Manager',
                          LoginGateway.staff => 'Kojo Asante  •  Dispenser',
                          _ => 'Pharm. David Mensah',
                        },
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        switch (widget.gateway) {
                          LoginGateway.manager => 'Pharmacy Manager • East Legon Flagship',
                          LoginGateway.staff => 'Dispensing Staff • Counter B',
                          _ => 'Lead Pharmacist • MPSGH / Reg. 4108',
                        },
                        style: const TextStyle(fontSize: 12, color: DcColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: DcColors.surfaceLow, borderRadius: BorderRadius.circular(999)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: DcColors.primary, borderRadius: BorderRadius.circular(999)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.call, size: 16, color: Colors.white),
                              SizedBox(width: 6),
                              Text('Phone Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text('OTP Verification', style: TextStyle(color: DcColors.onSurfaceVariant, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text("What's your phone number?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  switch (widget.gateway) {
                    LoginGateway.customer => "We'll use your number to securely access your DavidCare account and prescriptions.",
                    LoginGateway.pharmacist => 'Pharmacist OTP is issued only on this portal. Customer accounts cannot enter here.',
                    LoginGateway.manager => 'Manager OTP is issued only on this portal. Pharmacist and customer sessions stay isolated.',
                    LoginGateway.staff => 'Staff OTP is issued only on this portal. Clinical review stays on the pharmacist gateway.',
                  },
                  style: const TextStyle(color: DcColors.onSurfaceVariant, fontSize: 13),
                ),
                const SizedBox(height: 12),
                const Text('MOBILE NUMBER (MTN / TELECEL / AT)',
                    style: TextStyle(fontSize: 11, letterSpacing: 0.6, color: DcColors.onSurfaceVariant)),
                const SizedBox(height: 6),
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: DcColors.surfaceLow, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        child: const Text('+233', style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(border: InputBorder.none, filled: false, isDense: true),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Icon(Icons.check_circle, color: DcColors.secondary),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 6,
                  children: [
                    Pill('MTN MoMo'),
                    Pill('Telecel Cash', bg: DcColors.surfaceContainer, fg: DcColors.onSurface),
                    Pill('AT', bg: DcColors.surfaceContainer, fg: DcColors.onSurface),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () {
                    ref.read(sessionProvider.notifier).setPhone(_phone.text);
                    ref.read(sessionProvider.notifier).sendOtp();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Get Started / Continue'), Icon(Icons.arrow_forward, size: 18)],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('or', style: TextStyle(color: DcColors.onSurfaceVariant)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                ),
                OutlinedButton(onPressed: () {}, child: const Text('Continue with WhatsApp')),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: DcColors.surfaceLow, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.sms, size: 16, color: DcColors.secondary),
                          SizedBox(width: 6),
                          Text('Security Verification', style: TextStyle(fontWeight: FontWeight.w700)),
                          Spacer(),
                          Pill('Step 2 of 2', bg: DcColors.tertiaryFixed, fg: DcColors.tertiary),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Enter 6-digit code sent to'),
                      Text(_phone.text, style: const TextStyle(color: DcColors.primary, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 10),
                      Row(
                        children: List.generate(6, (i) {
                          return Expanded(
                            child: Container(
                              height: 52,
                              margin: EdgeInsets.only(right: i == 5 ? 0 : 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              child: Text(
                                _digits[i],
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: DcColors.primary),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () {
                          ref.read(sessionProvider.notifier).login(_role);
                          context.go(switch (widget.gateway) {
                            LoginGateway.customer => '/home',
                            LoginGateway.pharmacist => '/pharmacist',
                            LoginGateway.manager => '/manager',
                            LoginGateway.staff => '/staff',
                          });
                        },
                        child: Text(switch (widget.gateway) {
                          LoginGateway.customer => 'Authorize & Enter Pharmacy',
                          LoginGateway.pharmacist => 'Enter pharmacist workspace',
                          LoginGateway.manager => 'Enter manager console',
                          LoginGateway.staff => 'Enter dispensing hub',
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ghana FDA & Pharmacy Council regulated. Gateways are isolated by role — customer, pharmacist, manager, and staff sessions do not share a login.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: DcColors.onSurfaceVariant),
          ),
        ],
      ),
    );

    if (widget.gateway == LoginGateway.customer) {
      return PhoneFrame(child: Scaffold(backgroundColor: DcColors.background, body: body));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF8),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ColoredBox(color: DcColors.background, child: body),
        ),
      ),
    );
  }
}
