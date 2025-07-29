import 'package:marathondujeu/src/ui/pages/pages.dart';
import 'package:marathondujeu/src/ui/pages/utils/desktop.layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';


class Routes {
  static const playerList = 'playerList';
}

@TypedShellRoute<TopShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<PlayerListRoute>(path: '/', name: Routes.playerList),
  ]
)
@immutable
class TopShellRoute extends ShellRouteData {
  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator
  ) {

    return Consumer(builder: (context, ref, _) {
      return DesktopLayout(
        routerState : state,
        child: navigator,
      );
    });
  }
}

@immutable
class PlayerListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlayerListPage();
  }
}
