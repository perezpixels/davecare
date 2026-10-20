import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'theme/davecare_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: DavecareRoot()));
}

class DavecareRoot extends ConsumerWidget {
  const DavecareRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'DavidCare',
      debugShowCheckedModeBanner: false,
      theme: DavecareTheme.light(),
      routerConfig: router,
    );
  }
}
