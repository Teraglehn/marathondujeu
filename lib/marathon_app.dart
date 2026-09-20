import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:marathondujeu/theme.dart';
import 'package:marathondujeu/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';


class MarathonApp extends StatefulWidget {
  const MarathonApp({super.key});

  @override
  State<MarathonApp> createState() => _MarathonAppState();
}

class _MarathonAppState extends State<MarathonApp> {
  
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto Serif");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      theme: theme.light(),
      highContrastTheme: theme.lightHighContrast(),
      darkTheme: theme.dark(),
      highContrastDarkTheme: theme.darkHighContrast(),
      themeMode: ThemeMode.light,
      onGenerateTitle: (context) => S.of(context).app_title,
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      routerConfig: GoRouter(
        navigatorKey: rootNavigatorKey,
        routes: $appRoutes,
      ),
    );
  }
}
