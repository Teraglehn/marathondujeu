import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventSelectedGuard extends ConsumerWidget {
  final Widget child;

  const EventSelectedGuard({
    super.key, 
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final main = ref.watch(mainPodProvider);

    if(main.event == null){
      return const Center(
        child: Text("Please select a event"),
      );
    }

    return child;
  }
}