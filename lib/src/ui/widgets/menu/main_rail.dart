import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/ui/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainRail extends ConsumerWidget {
  final GoRouterState routerState;

  const MainRail({
    super.key,
    required this.routerState,
  });
  
  static final List<RouteItem> routes = [
    RouteItem((context) => S.of(context).page_eventList_menuItem, Routes.eventList, Icons.newspaper),
    RouteItem((context) => S.of(context).page_playerList_menuItem, Routes.playerList, Icons.person),
    RouteItem((context) => S.of(context).page_playerGroupsList_menuItem, Routes.playerGroupList, Icons.group),
    RouteItem((context) => S.of(context).page_sessionList_menuItem, Routes.sessionList, Icons.punch_clock),
    RouteItem((context) => S.of(context).page_drawList_menuItem, Routes.drawList, Icons.how_to_vote),
    RouteItem((context) => S.of(context).page_cardGenerator_menuItem, Routes.cardGenerator, Icons.qr_code),
    RouteItem((context) => S.of(context).help_guide_menuItem, Routes.help, Icons.help_outline),
  ];

  void _handleNavigation(BuildContext context, int selectedScreen) {
    GoRouter.of(context).goNamed(routes[selectedScreen].routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = routes.indexWhere((r) => r.routeName == routerState.topRoute?.name);
    // Sans événement en base, seule la liste des événements a quelque chose à montrer — et le
    // guide, qui dit comment en créer un (L12b).
    final noEvent = ref.watch(eventsProvider()).value?.isEmpty ?? false;
    return NavigationRail(
        useIndicator: true,
        onDestinationSelected: (i) => _handleNavigation(context, i),
        labelType: NavigationRailLabelType.all,
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        destinations: [
          ...routes.map((route) {
            final disabled = noEvent && route.routeName != Routes.eventList && route.routeName != Routes.help;
            return NavigationRailDestination(
              label: Text(route.getTitle(context)),
              icon: disabled
                ? Tooltip(message: S.of(context).widget_mainRail_createEventFirst, child: Icon(route.icon))
                : Icon(route.icon),
              disabled: disabled,
            );
          })
        ],
    );
  }
}
