import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models.dart';
import '../data/mock_store.dart';

enum AppRole { guest, customer, pharmacist, manager, staff }

enum LoginGateway { customer, pharmacist, manager, staff }

class SessionState {
  const SessionState({
    this.role = AppRole.guest,
    this.phone = '',
    this.otpSent = false,
    this.cart = const {},
    this.watched = const {'p5', 'p7'},
  });

  final AppRole role;
  final String phone;
  final bool otpSent;
  final Map<String, int> cart;
  final Set<String> watched;

  SessionState copyWith({
    AppRole? role,
    String? phone,
    bool? otpSent,
    Map<String, int>? cart,
    Set<String>? watched,
  }) {
    return SessionState(
      role: role ?? this.role,
      phone: phone ?? this.phone,
      otpSent: otpSent ?? this.otpSent,
      cart: cart ?? this.cart,
      watched: watched ?? this.watched,
    );
  }

  int get cartCount => cart.values.fold(0, (a, b) => a + b);

  double get cartTotal {
    var t = 0.0;
    for (final e in cart.entries) {
      final p = MockStore.products.firstWhere((x) => x.id == e.key);
      t += p.priceGhs * e.value;
    }
    return t;
  }

  List<ProductItem> get cartLines => MockStore.products.where((p) => cart.containsKey(p.id)).toList();

  String get homePath => switch (role) {
        AppRole.pharmacist => '/pharmacist',
        AppRole.manager => '/manager',
        AppRole.staff => '/staff',
        AppRole.customer => '/home',
        AppRole.guest => '/',
      };

  String get loginPath => switch (role) {
        AppRole.pharmacist => '/login/pharmacist',
        AppRole.manager => '/login/manager',
        AppRole.staff => '/login/staff',
        _ => '/login',
      };
}

class Session extends Notifier<SessionState> {
  @override
  SessionState build() => const SessionState();

  void setPhone(String phone) => state = state.copyWith(phone: phone);

  void sendOtp() => state = state.copyWith(otpSent: true);

  void login(AppRole role) => state = state.copyWith(role: role);

  void logout() => state = const SessionState();

  void addToCart(String id) {
    final next = Map<String, int>.from(state.cart);
    next[id] = (next[id] ?? 0) + 1;
    state = state.copyWith(cart: next);
  }

  void toggleWatch(String id) {
    final next = {...state.watched};
    if (!next.add(id)) next.remove(id);
    state = state.copyWith(watched: next);
  }
}

final sessionProvider = NotifierProvider<Session, SessionState>(Session.new);
