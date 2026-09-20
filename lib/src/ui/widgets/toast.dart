import 'package:flutter/material.dart';

/// La notification de l'application : en haut au centre de la fenêtre, 2 s (3 s pour une
/// erreur), une croix pour fermer. Une nouvelle notification remplace la précédente.
class Toast extends StatelessWidget {
  static const _duration = Duration(seconds: 2);
  static const _errorDuration = Duration(seconds: 3);
  static OverlayEntry? _current;

  final String message;
  final bool error;
  final VoidCallback onClose;

  const Toast({super.key, required this.message, required this.error, required this.onClose});

  static void show(BuildContext context, String message, {bool error = false}) {
    final overlay = Overlay.of(context, rootOverlay: true);
    _current?.remove();
    late final OverlayEntry entry;
    void close() {
      if (_current != entry) return;
      entry.remove();
      _current = null;
    }
    entry = OverlayEntry(builder: (_) => Toast(message: message, error: error, onClose: close));
    _current = entry;
    overlay.insert(entry);
    Future.delayed(error ? _errorDuration : _duration, close);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = error ? scheme.errorContainer : scheme.inverseSurface;
    final foreground = error ? scheme.onErrorContainer : scheme.onInverseSurface;
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Material(
            color: background,
            elevation: 6,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message, style: TextStyle(color: foreground)),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(Icons.close, color: foreground, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(width: 28, height: 28),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
