import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../state/session.dart';
import 'stitch_chrome.dart';
import 'stitch_embed.dart' if (dart.library.html) 'stitch_embed_web.dart';

/// Renders official Stitch HTML. Do not invent a parallel layout.
class StitchPage extends ConsumerWidget {
  const StitchPage({
    super.key,
    required this.asset,
    this.signInCustomer = false,
    this.phoneFrame = true,
    this.landing = false,
  });

  final String asset;
  final bool signInCustomer;
  final bool phoneFrame;
  final bool landing;

  static const _mobileBridge = r'''
<script>
(function () {
  function send(route) {
    try { parent.postMessage(JSON.stringify({ dcRoute: route }), '*'); } catch (e) {}
  }
  document.addEventListener('click', function (e) {
    var el = e.target && e.target.closest ? e.target.closest('a,button,[data-path]') : null;
    if (!el) return;
    var path = el.getAttribute('data-path') || '';
    var text = (el.innerText || '').replace(/\s+/g, ' ').trim();
    var route = null;
    if (path === 'home-feed') route = '/home';
    else if (path === 'shop-wellness') route = '/shop';
    else if (path === 'my-orders') route = '/orders';
    else if (path === 'health-regimen') route = '/health';
    else if (path === 'patient-profile') route = '/profile';
    else if (/Upload Rx|Upload New Prescription|Camera Scan|Photo Gallery|PDF Document/i.test(text)) route = '/health/prescriptions';
    else if (/Ask Pharm|Chat with Pharm|Send to Pharm|Reply to Pharm|Consult/i.test(text)) route = '/health/consultations';
    else if (/Live Consult|Type message/i.test(text)) route = '/health/consultations/c1';
    else if (/My Regimens|Health Regimen|Mark as Taken/i.test(text) && path === '') route = '/health';
    else if (/Book Visit|Confirm Appointment|Book a Clinical/i.test(text)) route = '/health/appointments';
    else if (/Order Again|Add to Order|Pay GH|Request Pharmacy Refill|Order Refill/i.test(text)) route = '/checkout';
    else if (/View Pickup|DC-1042|Live Tracker/i.test(text)) route = '/orders';
    else if (/Authorize|Enter Pharmacy|Get Started|Continue/i.test(text)) route = '/home';
    else if (/Family|Dependent|Register Dependent/i.test(text)) route = '/profile';
    else if (/History|Smart refill|Refill Window/i.test(text)) route = '/health/refills';
    if (route) {
      e.preventDefault();
      e.stopPropagation();
      send(route);
    }
  }, true);
})();
</script>
''';

  static const _landingBridge = r'''
<script>
(function () {
  function send(route) {
    try { parent.postMessage(JSON.stringify({ dcRoute: route }), '*'); } catch (e) {}
  }
  function scrollToId(id) {
    var t = document.getElementById(id);
    if (t) t.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
  document.addEventListener('click', function (e) {
    var el = e.target && e.target.closest ? e.target.closest('a,button,[data-path]') : null;
    if (!el) return;
    if (el.getAttribute('type') === 'button' && /Confirm On-Site Pharmacy Demo/i.test(el.innerText || '')) return;
    var path = el.getAttribute('data-path') || '';
    var href = el.getAttribute('href') || '';
    var text = (el.innerText || '').replace(/\s+/g, ' ').trim();
    if (path === 'patient-app' || /Explore Patient App|Download Patient App|Patient Mobile Regimen/i.test(text)) {
      e.preventDefault(); e.stopPropagation(); send('/login'); return;
    }
    if (path === 'get-started' || /^Get Started$/i.test(text) || /Start Free 30-Day Pilot|Request Group Onboarding/i.test(text)) {
      e.preventDefault(); e.stopPropagation(); send('/get-started'); return;
    }
    if (path === 'request-demo' || href === '#demo-modal' || /Request Pharmacy Demo|Book a Pharmacy Demo|Contact Clinical Solutions|Clinical Onboarding Desk|Confirm On-Site/i.test(text)) {
      e.preventDefault(); e.stopPropagation(); scrollToId('demo-modal'); return;
    }
    if (path === 'for-pharmacies' || path === 'platform-overview') {
      e.preventDefault(); e.stopPropagation(); scrollToId('dual-value'); return;
    }
    if (path === 'for-patients') {
      e.preventDefault(); e.stopPropagation(); scrollToId('dual-value'); return;
    }
    if (path === 'integration-ecosystem' || path === 'compliance-and-security') {
      e.preventDefault(); e.stopPropagation(); scrollToId('demo-modal'); return;
    }
  }, true);
})();
</script>
''';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = FutureBuilder<String>(
      future: rootBundle.loadString(asset),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const ColoredBox(
            color: Color(0xFFFAF8FF),
            child: Center(child: CircularProgressIndicator()),
          );
        }
          final injected = landing ? _withGetStarted(snap.data!) : snap.data!;
          final html = injected.replaceFirst(
            '</body>',
            '${landing ? _landingBridge : _mobileBridge}</body>',
          );
        return SizedBox.expand(
          child: StitchEmbed(
            html: html,
            onRoute: (route) {
              if (signInCustomer && (route == '/home' || route == '/shop')) {
                ref.read(sessionProvider.notifier).login(AppRole.customer);
              }
              context.go(route);
            },
          ),
        );
      },
    );

    if (!phoneFrame) return page;
    return PhoneFrame(child: page);
  }

  static String _withGetStarted(String html) {
    if (html.contains('data-path="get-started"')) return html;
    const button =
        '<a class="inline-flex items-center justify-center font-label-md text-label-md text-primary bg-surface-container-low hover:bg-surface-container hover:text-on-surface px-space-md py-space-sm rounded-full transition-all duration-200" data-path="get-started" href="#"><span class="material-symbols-outlined text-[18px] mr-space-xs text-primary">login</span>Get Started</a>';
    return html.replaceFirst(
      '<a class="inline-flex items-center justify-center font-label-md text-label-md text-on-primary bg-primary-container',
      '$button<a class="inline-flex items-center justify-center font-label-md text-label-md text-on-primary bg-primary-container',
    );
  }
}
