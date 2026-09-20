import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/ui/widgets/help/help.dart';

/// Le pas à pas d'une page (L12, Q1) : un voile sur toute la fenêtre, un trou autour de
/// l'élément visé, une bulle avec le texte du pas, *Suivant* / *Passer*. Il montre, il ne fait
/// pas faire : le voile absorbe les clics. Poussé sur le navigateur racine, par-dessus la page,
/// qui reste visible et telle quelle.
class HelpTour extends StatefulWidget {
  final List<HelpStep> steps;

  const HelpTour({super.key, required this.steps});

  static const _fade = Duration(milliseconds: 150);

  static Future<void> show(BuildContext context, List<HelpStep> steps) {
    if (steps.isEmpty) return Future.value();
    return Navigator.of(context, rootNavigator: true).push(PageRouteBuilder<void>(
      opaque: false,
      transitionDuration: _fade,
      reverseTransitionDuration: _fade,
      pageBuilder: (_, _, _) => HelpTour(steps: steps),
      transitionsBuilder: (_, animation, _, child) => FadeTransition(opacity: animation, child: child),
    ));
  }

  @override
  State<HelpTour> createState() => _HelpTourState();
}

class _HelpTourState extends State<HelpTour> {
  static const double _bubbleWidth = 380;
  static const double _gap = 12;

  int _index = 0;
  // La cible du pas, en coordonnées de la fenêtre ; null tant qu'elle n'est pas mesurée, ou
  // pour un pas sans cible.
  Rect? _hole;
  bool _measuring = true;

  @override
  void initState() {
    super.initState();
    _goTo(0);
  }

  HelpStep get _step => widget.steps[_index];
  bool get _last => _index == widget.steps.length - 1;

  void _close() => Navigator.of(context).pop();

  // Va au pas [index], en sautant ceux dont la cible n'est pas à l'écran. La cible est amenée
  // dans la vue avant d'être mesurée.
  Future<void> _goTo(int index) async {
    while (index < widget.steps.length && widget.steps[index].target != null && widget.steps[index].target!.currentContext == null) {
      index++;
    }
    if (index >= widget.steps.length) {
      _close();
      return;
    }
    setState(() {
      _index = index;
      _hole = null;
      _measuring = true;
    });
    final targetContext = widget.steps[index].target?.currentContext;
    if (targetContext != null) {
      await Scrollable.ensureVisible(targetContext, alignment: 0.5, duration: const Duration(milliseconds: 200));
      await WidgetsBinding.instance.endOfFrame;
    }
    if (!mounted || _index != index) return;
    setState(() {
      _hole = _rectOf(targetContext);
      _measuring = false;
    });
  }

  Rect? _rectOf(BuildContext? targetContext) {
    final box = targetContext?.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return null;
    return (box.localToGlobal(Offset.zero) & box.size).inflate(6);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CallbackShortcuts(
      bindings: {const SingleActivator(LogicalKeyboardKey.escape): _close},
      child: FocusScope(
        autofocus: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: LayoutBuilder(builder: (context, constraints) {
            final size = constraints.biggest;
            return Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _VeilPainter(hole: _hole, color: scheme.scrim.withValues(alpha: 0.6), border: scheme.primary),
                  ),
                ),
                if (!_measuring) _positioned(size, _bubble(context)),
              ],
            );
          }),
        ),
      ),
    );
  }

  // La bulle sous la cible quand elle est dans la moitié haute, au-dessus sinon ; centrée sur
  // elle, sans sortir de la fenêtre. Sans cible : au centre.
  Widget _positioned(Size size, Widget bubble) {
    final hole = _hole;
    if (hole == null) return Center(child: bubble);
    final left = (hole.center.dx - _bubbleWidth / 2).clamp(16.0, size.width - _bubbleWidth - 16.0);
    if (hole.center.dy < size.height / 2) {
      return Positioned(top: hole.bottom + _gap, left: left, child: bubble);
    }
    return Positioned(bottom: size.height - hole.top + _gap, left: left, child: bubble);
  }

  Widget _bubble(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return SizedBox(
      width: _bubbleWidth,
      child: Material(
        elevation: 8,
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(s.help_counter(_index + 1, widget.steps.length), style: theme.textTheme.labelMedium),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.close), tooltip: s.utils_button_close, onPressed: _close),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(_step.text, style: theme.textTheme.bodyLarge),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!_last) TextButton(onPressed: _close, child: Text(s.help_skip)),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _last ? _close : () => _goTo(_index + 1),
                    child: Text(_last ? s.help_finish : s.help_next),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Le voile, moins le trou arrondi autour de la cible, et un liseré autour du trou.
class _VeilPainter extends CustomPainter {
  final Rect? hole;
  final Color color;
  final Color border;

  const _VeilPainter({required this.hole, required this.color, required this.border});

  @override
  void paint(Canvas canvas, Size size) {
    final full = Path()..addRect(Offset.zero & size);
    final hole = this.hole;
    if (hole == null) {
      canvas.drawPath(full, Paint()..color = color);
      return;
    }
    final rounded = RRect.fromRectAndRadius(hole, const Radius.circular(8));
    canvas.drawPath(Path.combine(PathOperation.difference, full, Path()..addRRect(rounded)), Paint()..color = color);
    canvas.drawRRect(rounded, Paint()..color = border..style = PaintingStyle.stroke..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(_VeilPainter oldDelegate) => hole != oldDelegate.hole || color != oldDelegate.color || border != oldDelegate.border;
}
