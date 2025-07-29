import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:marathondujeu/src/ui/pages/utils/edit_drawer_widget.dart';
import 'package:marathondujeu/src/ui/widgets/menu/main_rail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DesktopLayout extends ConsumerWidget {
  final Widget child;
  final GoRouterState routerState;

  DesktopLayout({
    super.key, 
    required this.child,
    required this.routerState,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editorPodProvider);

    final scaffold = Scaffold(
      key: _scaffoldKey,
      endDrawer: EditDrawerWidget(state: state),
      onEndDrawerChanged: (open){
        if(!open){
          ref.read(editorPodProvider.notifier).close();
        }
      },
      body: Row(
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
    );

    if(state.isEditing){
      Future.microtask(() => _scaffoldKey.currentState?.openEndDrawer());
    } else {
      Future.microtask(() => _scaffoldKey.currentState?.closeEndDrawer());
    }

    return scaffold;
  }
}