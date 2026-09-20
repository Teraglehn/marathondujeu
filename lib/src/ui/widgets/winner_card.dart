import 'package:flutter/material.dart';

/// Un gagnant d'un tirage : son rang (« N°1 ») et la bille de son numéro. Widget pur — le
/// guide (L12b) l'affiche avec des valeurs d'exemple.
class WinnerCard extends StatelessWidget {
  final int position;
  final int number;
  final VoidCallback? onTap;

  const WinnerCard({super.key, required this.position, required this.number, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text("N°$position"),
            ),
            CircleAvatar(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              child: Text(number.toString())
            )
          ])
        ),
      )
    );
  }
}
