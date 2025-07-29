import 'dart:io' show Platform;
import 'package:marathondujeu/marathon_app.dart';
import 'package:marathondujeu/services_injector.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  setupWindow();
  runApp(const ProviderScope(
    child: EagerInitialization(
      child: MarathonApp()
    )
  ));
}

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
