import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class StitchEmbed extends StatefulWidget {
  const StitchEmbed({super.key, required this.html, required this.onRoute});

  final String html;
  final void Function(String route) onRoute;

  @override
  State<StitchEmbed> createState() => _StitchEmbedState();
}

class _StitchEmbedState extends State<StitchEmbed> {
  late final String _viewType;
  late final web.EventListener _listener;

  @override
  void initState() {
    super.initState();
    _viewType = 'stitch-${identityHashCode(this)}';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int _) {
      final iframe = web.HTMLIFrameElement();
      iframe.setAttribute('srcdoc', widget.html);
      iframe.style.setProperty('border', 'none');
      iframe.style.setProperty('width', '100%');
      iframe.style.setProperty('height', '100%');
      return iframe;
    });
    _listener = (web.Event event) {
      final message = event as web.MessageEvent;
      final decoded = message.data.dartify();
      String? route;
      if (decoded is String) {
        try {
          final map = jsonDecode(decoded);
          if (map is Map && map['dcRoute'] is String) {
            route = map['dcRoute'] as String;
          }
        } catch (_) {}
      }
      if (route != null && mounted) widget.onRoute(route);
    }.toJS;
    web.window.addEventListener('message', _listener);
  }

  @override
  void dispose() {
    web.window.removeEventListener('message', _listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
