import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/login_screen.dart';
import 'features/auth/onboard_screen.dart';
import 'features/customer/customer_shell.dart';
import 'features/customer/stitch_page.dart';
import 'features/pharmacy/pharmacy_screens.dart';
import 'state/session.dart';

final _rootKey = GlobalKey<NavigatorState>();

List<RouteBase> _pharmacyTree(String prefix, {Widget? home}) => [
      GoRoute(path: prefix, builder: (c, s) => home ?? const PharmacyDashboard()),
      GoRoute(path: '$prefix/prescriptions', builder: (c, s) => const PharmacyPrescriptions()),
      GoRoute(
        path: '$prefix/prescriptions/:id',
        builder: (c, s) => PharmacyPrescriptionReview(id: s.pathParameters['id']!),
      ),
      GoRoute(path: '$prefix/consultations', builder: (c, s) => const PharmacyConsultations()),
      GoRoute(path: '$prefix/follow-ups', builder: (c, s) => const PharmacyFollowUps()),
      GoRoute(path: '$prefix/appointments', builder: (c, s) => const PharmacyAppointments()),
      GoRoute(path: '$prefix/customers', builder: (c, s) => const PharmacyCustomers()),
      GoRoute(
        path: '$prefix/customers/:name',
        builder: (c, s) => PharmacyCustomer360(name: s.pathParameters['name']!),
      ),
      GoRoute(path: '$prefix/orders', builder: (c, s) => const PharmacyOrders()),
      GoRoute(path: '$prefix/demand', builder: (c, s) => const PharmacyDemand()),
      GoRoute(
        path: '$prefix/catalogue',
        builder: (c, s) => const PharmacySimplePage(
          title: 'Customer-facing catalogue',
          body: 'Availability can be synced from the pharmacy system. This is not a stock ledger, warehouse, or POS.',
        ),
      ),
      GoRoute(
        path: '$prefix/reports',
        builder: (c, s) => const PharmacySimplePage(
          title: 'Reports & analytics',
          body: 'Descriptive insights only. No medical predictions in MVP.',
        ),
      ),
      GoRoute(
        path: '$prefix/integrations',
        builder: (c, s) => const PharmacySimplePage(
          title: 'POS & MoMo sync',
          body: 'Adapter interface only. DavidCare is not a POS. Mock adapter until a real provider is connected.',
        ),
      ),
      GoRoute(
        path: '$prefix/settings',
        builder: (c, s) => const PharmacySimplePage(
          title: 'Staff & settings',
          body: 'RBAC is enforced on the API. UI visibility is not authorization.',
        ),
      ),
    ];

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(sessionProvider, (previous, next) => refresh.value++);
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final role = ref.read(sessionProvider).role;
      final loc = state.matchedLocation;
      if (loc == '/login/landing' || loc == '/login/platform' || loc.startsWith('/platform')) {
        return '/';
      }

      final onLanding = loc == '/';
      final onOnboard = loc == '/get-started';
      final onCustomerLogin = loc == '/login';
      final onPharmacistLogin = loc == '/login/pharmacist';
      final onManagerLogin = loc == '/login/manager';
      final onStaffLogin = loc == '/login/staff';
      final onPublicAuth =
          onLanding || onOnboard || onCustomerLogin || onPharmacistLogin || onManagerLogin || onStaffLogin;

      if (role == AppRole.guest) {
        if (onPublicAuth) return null;
        if (loc.startsWith('/pharmacist')) return '/login/pharmacist';
        if (loc.startsWith('/manager')) return '/login/manager';
        if (loc.startsWith('/staff')) return '/login/staff';
        return '/';
      }

      if (onOnboard || onCustomerLogin || onPharmacistLogin || onManagerLogin || onStaffLogin) {
        return switch (role) {
          AppRole.customer => '/home',
          AppRole.pharmacist => '/pharmacist',
          AppRole.manager => '/manager',
          AppRole.staff => '/staff',
          AppRole.guest => null,
        };
      }

      if (onLanding) return null;

      if (role == AppRole.customer &&
          (loc.startsWith('/pharmacist') || loc.startsWith('/manager') || loc.startsWith('/staff'))) {
        return '/home';
      }
      if (role == AppRole.pharmacist && !loc.startsWith('/pharmacist')) {
        return '/pharmacist';
      }
      if (role == AppRole.manager && !loc.startsWith('/manager')) {
        return '/manager';
      }
      if (role == AppRole.staff && !loc.startsWith('/staff')) {
        return '/staff';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (c, s) => const StitchPage(
          asset: 'assets/stitch_html/landing.html',
          phoneFrame: false,
          landing: true,
        ),
      ),
      GoRoute(path: '/login/landing', redirect: (c, s) => '/'),
      GoRoute(path: '/get-started', builder: (c, s) => const OnboardScreen()),
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen(gateway: LoginGateway.customer)),
      GoRoute(path: '/login/pharmacist', builder: (c, s) => const LoginScreen(gateway: LoginGateway.pharmacist)),
      GoRoute(path: '/login/manager', builder: (c, s) => const LoginScreen(gateway: LoginGateway.manager)),
      GoRoute(path: '/login/staff', builder: (c, s) => const LoginScreen(gateway: LoginGateway.staff)),
      ShellRoute(
        builder: (c, s, child) => CustomerShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/home.html')),
          GoRoute(path: '/shop', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/shop.html')),
          GoRoute(path: '/orders', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/orders.html')),
          GoRoute(path: '/orders/:id', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/orders.html')),
          GoRoute(path: '/health', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/health.html')),
          GoRoute(path: '/profile', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/family.html')),
        ],
      ),
      GoRoute(path: '/checkout', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/checkout.html')),
      GoRoute(path: '/health/timeline', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/health.html')),
      GoRoute(path: '/health/prescriptions', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/prescriptions.html')),
      GoRoute(path: '/health/refills', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/refills.html')),
      GoRoute(path: '/health/consultations', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/consult_hub.html')),
      GoRoute(path: '/health/consultations/:id', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/consult_chat.html')),
      GoRoute(path: '/health/appointments', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/appointments.html')),
      GoRoute(path: '/health/family', builder: (c, s) => const StitchPage(asset: 'assets/stitch_html/family.html')),
      ShellRoute(
        builder: (c, s, child) => PharmacyShell(workspace: AppRole.pharmacist, child: child),
        routes: _pharmacyTree('/pharmacist'),
      ),
      ShellRoute(
        builder: (c, s, child) => PharmacyShell(workspace: AppRole.manager, child: child),
        routes: _pharmacyTree('/manager'),
      ),
      ShellRoute(
        builder: (c, s, child) => PharmacyShell(workspace: AppRole.staff, child: child),
        routes: _pharmacyTree('/staff', home: const PharmacyOrders()),
      ),
    ],
  );
});
