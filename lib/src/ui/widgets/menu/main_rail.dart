import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/ui/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainRail extends StatelessWidget {
  final GoRouterState routerState;

  const MainRail({
    super.key,
    required this.routerState,
  });
  
  static final List<RouteItem> routes = [
    RouteItem((context) => S.of(context).page_eventList_menuItem, Routes.eventList, Icons.newspaper),
    RouteItem((context) => S.of(context).page_playerList_menuItem, Routes.playerList, Icons.group),
    RouteItem((context) => S.of(context).page_sessionList_menuItem, Routes.sessionList, Icons.punch_clock),
    RouteItem((context) => S.of(context).page_drawList_menuItem, Routes.drawList, Icons.how_to_vote),
    RouteItem((context) => S.of(context).page_cardGenerator_menuItem, Routes.cardGenerator, Icons.qr_code),
  ];

  void _handleNavigation(BuildContext context, int selectedScreen) {
    GoRouter.of(context).goNamed(routes[selectedScreen].routeName);
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = routes.indexWhere((r) => r.routeName == routerState.topRoute?.name);
    return NavigationRail(
        useIndicator: true,
        onDestinationSelected: (i) => _handleNavigation(context, i),
        labelType: NavigationRailLabelType.all,
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        destinations: [
          ...routes.map((route) => NavigationRailDestination(
            label: Text(route.getTitle(context)),
            icon: Icon(route.icon),
          ))
        ],
    );
  }
}


