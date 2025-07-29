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
          name: 'playerList',
          factory: $PlayerListRouteExtension._fromState,
        ),
      ],
    );

extension $TopShellRouteExtension on TopShellRoute {
  static TopShellRoute _fromState(GoRouterState state) => TopShellRoute();
}

extension $PlayerListRouteExtension on PlayerListRoute {
  static PlayerListRoute _fromState(GoRouterState state) => PlayerListRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
