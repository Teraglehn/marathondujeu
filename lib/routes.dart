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
}

@TypedShellRoute<TopShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<EventListRoute>(path: '/', name: Routes.eventList),
    TypedGoRoute<PlayerListRoute>(path: '/players', name: Routes.playerList),
    TypedGoRoute<SessionListRoute>(path: '/sessions', name: Routes.sessionList),
    TypedGoRoute<CardGeneratorRoute>(path: '/cardGenerator', name: Routes.cardGenerator),
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
class EventListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EventListPage();
  }
}

@immutable
class PlayerListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlayerListPage();
  }
}

@immutable
class SessionListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SessionListPage();
  }
}


@immutable
class CardGeneratorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CardGeneratorPage();
  }
}
