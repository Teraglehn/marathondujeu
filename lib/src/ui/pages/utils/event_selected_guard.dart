import 'package:marathondujeu/src/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';

class EventSelectedGuard extends ConsumerWidget {
  final Widget Function(Event) builder;

  const EventSelectedGuard({
    super.key, 
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);

    if(selectedEvent.value == null){
      return const Center(
        child: Text("Please select a event"),
      );
    }

    return builder(selectedEvent.value!);
  }
}