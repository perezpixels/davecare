import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:davecare/main.dart';

void main() {
  testWidgets('app boots to SaaS landing', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: DavecareRoot()));
    await tester.pump();
    expect(find.byType(DavecareRoot), findsOneWidget);
  });
}
