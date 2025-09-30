// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $topShellRoute,
    ];

RouteBase get $topShellRoute => ShellRouteData.$route(
      factory: $TopShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'eventList',
          factory: $EventListRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/players',
          name: 'playerList',
          factory: $PlayerListRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/sessions',
          name: 'sessionList',
          factory: $SessionListRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/session',
          name: 'session',
          factory: $SessionRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/cardGenerator',
          name: 'cardGenerator',
          factory: $CardGeneratorRouteExtension._fromState,
        ),
      ],
    );

extension $TopShellRouteExtension on TopShellRoute {
  static TopShellRoute _fromState(GoRouterState state) => TopShellRoute();
}

extension $EventListRouteExtension on EventListRoute {
  static EventListRoute _fromState(GoRouterState state) => EventListRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PlayerListRouteExtension on PlayerListRoute {
  static PlayerListRoute _fromState(GoRouterState state) => PlayerListRoute();

  String get location => GoRouteData.$location(
        '/players',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SessionListRouteExtension on SessionListRoute {
  static SessionListRoute _fromState(GoRouterState state) => SessionListRoute();

  String get location => GoRouteData.$location(
        '/sessions',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SessionRouteExtension on SessionRoute {
  static SessionRoute _fromState(GoRouterState state) => SessionRoute();

  String get location => GoRouteData.$location(
        '/session',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CardGeneratorRouteExtension on CardGeneratorRoute {
  static CardGeneratorRoute _fromState(GoRouterState state) =>
      CardGeneratorRoute();

  String get location => GoRouteData.$location(
        '/cardGenerator',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
