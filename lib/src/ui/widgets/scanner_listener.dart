import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Écoute la douchette : elle est un clavier qui tape les caractères du code en rafale, puis
/// Entrée. Les caractères reçus à moins de [bufferDuration] les uns des autres font le code ;
/// Entrée le livre à [onScanned]. Une frappe isolée plus ancienne est oubliée.
///
/// Lit le **caractère tapé** (`KeyDownEvent.character`), pas le code de touche : sous Windows,
/// le code de touche donne `A` pour `a` et `½` pour `-`, et une carte protégée n'était plus
/// reconnue (L18, Q4). Les touches ne sont pas consommées : un champ qui a le focus les reçoit
/// aussi, comme avec un vrai clavier.
class ScannerListener extends StatefulWidget {
  final Widget child;
  final void Function(String code) onScanned;
  final Duration bufferDuration;

  const ScannerListener({
    super.key,
    required this.child,
    required this.onScanned,
    this.bufferDuration = const Duration(milliseconds: 100),
  });

  @override
  State<ScannerListener> createState() => _ScannerListenerState();
}

class _ScannerListenerState extends State<ScannerListener> {
  final _buffer = StringBuffer();
  DateTime? _lastKeyAt;

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handle);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handle);
    super.dispose();
  }

  bool _handle(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    final now = DateTime.now();
    if (_lastKeyAt != null && now.difference(_lastKeyAt!) > widget.bufferDuration) _buffer.clear();
    _lastKeyAt = now;

    if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
      final code = _buffer.toString();
      _buffer.clear();
      widget.onScanned(code);
      return false;
    }
    final character = event.character;
    if (character != null && character.isNotEmpty) _buffer.write(character);
    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
