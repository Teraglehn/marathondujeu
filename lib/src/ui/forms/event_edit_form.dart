import 'package:flutter/services.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/pods/events.dart';
import 'package:marathondujeu/src/pods/editor_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marathondujeu/src/services/formatters_service.dart';
import 'package:marathondujeu/src/ui/widgets/fields/datetime_form_field.dart';

class EventEditForm extends ConsumerStatefulWidget {

  final Event event;

  final bool allowRemove;

  const EventEditForm(
    this.event, 
    {
      this.allowRemove = true,
      super.key,
    });

  @override
  ConsumerState<EventEditForm> createState() => _EventEditFormState();
}

class _EventEditFormState extends ConsumerState<EventEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _sessionTimeMinuteController = TextEditingController();
  final _sessionIntervalMinuteController = TextEditingController();
  bool generateSessions = false;

  @override
  void initState(){
    super.initState();
    _sessionTimeMinuteController.text = widget.event.sessionTimeMinutes.toString();
    _sessionIntervalMinuteController.text = widget.event.sessionIntervalMinutes.toString();
  }

  void save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.event.sessionTimeMinutes = int.parse(_sessionTimeMinuteController.text);
    widget.event.sessionIntervalMinutes = int.parse(_sessionIntervalMinuteController.text);

    _formKey.currentState!.save();
    
    ref.read(eventsProvider().notifier)
      .save(widget.event, generateSessions: generateSessions)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void delete(){
    ref.read(eventsProvider().notifier)
      .delete(widget.event)
      .then((_) => ref.read(editorPodProvider.notifier).close());
  }

  void cancel(){
    ref.read(editorPodProvider.notifier).close();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.event.name,
              decoration: InputDecoration(
                labelText: S.of(context).data_event_name,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_event_error_name_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.event.name = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimeFormField(
              initialValue: widget.event.startDateTime,
              label: S.of(context).data_event_datetime_start,
              validator: (value) {
                if (value == null) {
                  return S.of(context).data_event_error_datetime_start_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.event.startDateTime = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimeFormField(
              initialValue: widget.event.endDateTime,
              label: S.of(context).data_event_datetime_end,
              validator: (value) {
                if (value == null) {
                  return S.of(context).data_event_error_datetime_end_required;
                }
                return null;
              },
              onSaved: (value) {
                widget.event.endDateTime = value!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _sessionTimeMinuteController,
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              inputFormatters: <TextInputFormatter>[FormattersService.integer],
              decoration: InputDecoration(
                labelText: S.of(context).data_event_session_duration_minute,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_event_error_session_duration_minute_required;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _sessionIntervalMinuteController,
              keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
              inputFormatters: <TextInputFormatter>[FormattersService.integer],
              decoration: InputDecoration(
                labelText: S.of(context).data_event_session_interval_minute,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).data_event_error_session_interval_minute_required;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
              title: Text(S.of(context).page_eventList_generateSessions),
              value: generateSessions,
              onChanged:(bool? value) {
                setState(() {
                  generateSessions = !generateSessions;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.allowRemove) TextButton.icon(
                  onPressed: delete,
                  icon: const Icon(Icons.delete),
                  label: Text(S.of(context).utils_button_delete),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: cancel,
                  label: Text(S.of(context).utils_button_cancel),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                TextButton.icon(
                  onPressed: save,
                  label: Text(S.of(context).utils_button_save),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}