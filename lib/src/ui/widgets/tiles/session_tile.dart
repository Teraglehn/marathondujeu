import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:marathondujeu/src/data/data.dart';

class ColorSelector extends StatelessWidget {

  final Session session;

  const ColorSelector({
    required this.session,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${session.startTime.toIso8601String()} ${session.endTime?.toIso8601String() ?? ""}"),
    );
  }

}