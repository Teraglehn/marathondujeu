import 'package:flutter/services.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/ui/pages/utils/edit_drawer_widget.dart';
import 'package:marathondujeu/src/ui/widgets/menu/main_rail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DesktopLayout extends ConsumerWidget {
  final Widget child;
  final GoRouterState routerState;

  const DesktopLayout({
    super.key, 
    required this.child,
    required this.routerState,
  });

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editorPodProvider);
    void requestClose() => ref.read(editorPodProvider.notifier).requestClose(context);

    // Le tiroir n'est pas celui du Scaffold : son voile fermait — et détruisait le formulaire —
    // avant de prévenir. Ici le voile et Échap passent par `requestClose`.
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              MainRail(
                routerState: routerState,
              ),
              const VerticalDivider(width: 1.0),
              Expanded(
                child: child,
              ),
            ],
          ),
          AnimatedSwitcher(
            duration: _duration,
            child: state.isEditing
              ? ModalBarrier(key: const ValueKey('editor-barrier'), color: Colors.black54, onDismiss: requestClose)
              : const SizedBox.shrink(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedSwitcher(
              duration: _duration,
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                child: child,
              ),
              child: state.isEditing
                ? CallbackShortcuts(
                    key: const ValueKey('editor-drawer'),
                    bindings: {const SingleActivator(LogicalKeyboardKey.escape): requestClose},
                    child: FocusScope(autofocus: true, child: EditDrawerWidget(state: state)),
                  )
                : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
