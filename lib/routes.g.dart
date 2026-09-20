// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$topShellRoute];

RouteBase get $topShellRoute => ShellRouteData.$route(
  factory: $TopShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/',
      name: 'eventList',
      hasOverriddenOnExit: false,
      factory: $EventListRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/players',
      name: 'playerList',
      hasOverriddenOnExit: false,
      factory: $PlayerListRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/draws',
      name: 'drawList',
      hasOverriddenOnExit: false,
      factory: $DrawListRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/sessions',
      name: 'sessionList',
      hasOverriddenOnExit: false,
      factory: $SessionListRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/session',
      name: 'session',
      hasOverriddenOnExit: false,
      factory: $SessionRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/playerGroups',
      name: 'playerGroupList',
      hasOverriddenOnExit: false,
      factory: $PlayerGroupListRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/playerGroup',
      name: 'playerGroup',
      hasOverriddenOnExit: false,
      factory: $PlayerGroupRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/cardGenerator',
      name: 'cardGenerator',
      hasOverriddenOnExit: false,
      factory: $CardGeneratorRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/help',
      name: 'help',
      hasOverriddenOnExit: false,
      factory: $HelpRoute._fromState,
    ),
  ],
);

extension $TopShellRouteExtension on TopShellRoute {
  static TopShellRoute _fromState(GoRouterState state) => TopShellRoute();
}

mixin $EventListRoute on GoRouteData {
  static EventListRoute _fromState(GoRouterState state) => EventListRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PlayerListRoute on GoRouteData {
  static PlayerListRoute _fromState(GoRouterState state) => PlayerListRoute();

  @override
  String get location => GoRouteData.$location('/players');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DrawListRoute on GoRouteData {
  static DrawListRoute _fromState(GoRouterState state) => DrawListRoute();

  @override
  String get location => GoRouteData.$location('/draws');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SessionListRoute on GoRouteData {
  static SessionListRoute _fromState(GoRouterState state) => SessionListRoute();

  @override
  String get location => GoRouteData.$location('/sessions');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SessionRoute on GoRouteData {
  static SessionRoute _fromState(GoRouterState state) => SessionRoute();

  @override
  String get location => GoRouteData.$location('/session');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PlayerGroupListRoute on GoRouteData {
  static PlayerGroupListRoute _fromState(GoRouterState state) =>
      PlayerGroupListRoute();

  @override
  String get location => GoRouteData.$location('/playerGroups');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PlayerGroupRoute on GoRouteData {
  static PlayerGroupRoute _fromState(GoRouterState state) => PlayerGroupRoute();

  @override
  String get location => GoRouteData.$location('/playerGroup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CardGeneratorRoute on GoRouteData {
  static CardGeneratorRoute _fromState(GoRouterState state) =>
      CardGeneratorRoute();

  @override
  String get location => GoRouteData.$location('/cardGenerator');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HelpRoute on GoRouteData {
  static HelpRoute _fromState(GoRouterState state) => HelpRoute();

  @override
  String get location => GoRouteData.$location('/help');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
