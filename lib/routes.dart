import 'package:marathondujeu/src/ui/pages/pages.dart';
import 'package:marathondujeu/src/ui/pages/utils/desktop.layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';


class Routes {
  static const eventList = 'eventList';
  static const playerList = 'playerList';
  static const cardGenerator = 'cardGenerator';
  static const sessionList = 'sessionList';
  static const session = 'session';
  static const playerGroupList = 'playerGroupList';
  static const playerGroup = 'playerGroup';
  static const drawList = 'drawList';
  static const help = 'help';
}

@TypedShellRoute<TopShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<EventListRoute>(path: '/', name: Routes.eventList),
    TypedGoRoute<PlayerListRoute>(path: '/players', name: Routes.playerList),
    TypedGoRoute<DrawListRoute>(path: '/draws', name: Routes.drawList),
    TypedGoRoute<SessionListRoute>(path: '/sessions', name: Routes.sessionList),
    TypedGoRoute<SessionRoute>(path: '/session', name: Routes.session),
    TypedGoRoute<PlayerGroupListRoute>(path: '/playerGroups', name: Routes.playerGroupList),
    TypedGoRoute<PlayerGroupRoute>(path: '/playerGroup', name: Routes.playerGroup),
    TypedGoRoute<CardGeneratorRoute>(path: '/cardGenerator', name: Routes.cardGenerator),
    TypedGoRoute<HelpRoute>(path: '/help', name: Routes.help),
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
class EventListRoute extends GoRouteData with $EventListRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EventListPage();
  }
}

@immutable
class DrawListRoute extends GoRouteData with $DrawListRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DrawListPage();
  }
}

@immutable
class PlayerListRoute extends GoRouteData with $PlayerListRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlayerListPage();
  }
}

@immutable
class SessionListRoute extends GoRouteData with $SessionListRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SessionListPage();
  }
}

@immutable
class SessionRoute extends GoRouteData with $SessionRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SessionPage();
  }
}

@immutable
class PlayerGroupListRoute extends GoRouteData with $PlayerGroupListRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlayerGroupListPage();
  }
}

@immutable
class PlayerGroupRoute extends GoRouteData with $PlayerGroupRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlayerGroupPage();
  }
}


@immutable
class CardGeneratorRoute extends GoRouteData with $CardGeneratorRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CardGeneratorPage();
  }
}

@immutable
class HelpRoute extends GoRouteData with $HelpRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HelpPage();
  }
}
