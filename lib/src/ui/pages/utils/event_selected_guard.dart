import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/routes.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/main_pod.dart';
import 'package:marathondujeu/src/pods/selected_event.dart';
import 'package:marathondujeu/src/ui/widgets/fields/event_selector.dart';

/// Protège une page qui exige un événement.
/// - Aucun événement en base : renvoie vers la liste des événements.
/// - Aucun événement sélectionné : ouvre le sélecteur d'office, puis laisse un bouton pour le rouvrir.
class EventSelectedGuard extends ConsumerWidget {
  final Widget Function(Event) builder;

  const EventSelectedGuard({
    super.key, 
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);
    final events = ref.watch(eventsProvider());

    // Tant qu'on ne sait pas, on n'affiche rien et on ne décide rien.
    if (!events.hasValue || (selectedEvent.isLoading && !selectedEvent.hasValue)) {
      return const SizedBox.shrink();
    }

    if (events.value!.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.goNamed(Routes.eventList);
      });
      return const SizedBox.shrink();
    }

    if (selectedEvent.value == null) {
      return const _NoEventBody();
    }

    return builder(selectedEvent.value!);
  }
}

class _NoEventBody extends ConsumerWidget {
  const _NoEventBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainNotifier = ref.watch(mainPodProvider.notifier);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).widget_eventSelectedGuard_pleaseSelectEvent),
          const SizedBox(height: 16),
          EventSelector(
            autoOpen: true,
            onChanged: (event) => mainNotifier.setEventId(event?.id),
            anchorBuilder: (state, value, toggleSearch) => (context, controller) => FilledButton.icon(
              onPressed: () => toggleSearch(controller),
              icon: const Icon(Icons.event),
              label: Text(S.of(context).widget_eventSelectedGuard_chooseEvent),
            ),
          ),
        ],
      ),
    );
  }
}
