import 'package:flutter/material.dart';

/// La bille d'un joueur : son numéro dans un rond.
class PlayerBubble extends StatelessWidget {
  static const double size = 44;

  final int number;
  final Color color;
  final Color foregroundColor;

  const PlayerBubble({
    super.key,
    required this.number,
    required this.color,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: color,
        foregroundColor: foregroundColor,
        child: Text(number.toString()),
      ),
    );
  }
}

/// Une bille et son bouton *Retirer*, dans une carte : la forme du mode suppression, partagée
/// entre la page d'une session et celle d'un groupe.
class RemovableBubble extends StatelessWidget {
  final PlayerBubble bubble;
  final String label;
  final VoidCallback onRemove;

  const RemovableBubble({
    super.key,
    required this.bubble,
    required this.label,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            bubble,
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              onPressed: onRemove,
              icon: const Icon(Icons.delete, size: 18),
              label: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
