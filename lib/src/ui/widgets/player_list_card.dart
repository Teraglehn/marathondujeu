import 'package:flutter/material.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/data/data.dart';

/// La carte d'un joueur dans la liste : la ligne du numéro et du nom, puis trois lignes
/// compactes — sessions badgées, bonus (avec ses boutons « − » / « + »), jetons. Widget pur —
/// le guide (L12b) l'affiche avec des valeurs d'exemple.
class PlayerListCard extends StatelessWidget {
  // La ligne du nom (dense, 48 px), trois lignes compactes (40 px), les marges de la Card.
  static const double width = 200;
  static const double height = 48 + 3 * 40 + 8;

  final int number;
  final String name;
  final int sessions;
  final int bonus;
  final int tokens;
  final VoidCallback? onTap;
  final void Function(int delta)? onBonus;

  /// Des valeurs simples, pas un `Player` : ses compteurs lisent des liens Isar, qui refusent
  /// un objet non enregistré — celui du guide.
  const PlayerListCard({
    super.key,
    required this.number,
    required this.name,
    required this.sessions,
    required this.bonus,
    required this.tokens,
    this.onTap,
    this.onBonus,
  });

  /// La carte d'un joueur de la base.
  PlayerListCard.of(Player player, {super.key, this.onTap, this.onBonus})
    : number = player.number,
      name = player.name,
      sessions = player.getSessionNumber(),
      bonus = player.bonusSession,
      tokens = player.getTokenCount();

  Widget bonusButton(IconData icon, VoidCallback? onPressed) => IconButton.filledTonal(
    onPressed: onPressed,
    icon: Icon(icon, size: 16),
    padding: EdgeInsets.zero,
    mouseCursor: SystemMouseCursors.click,
    constraints: const BoxConstraints.tightFor(width: 28, height: 28),
  );

  /// Bille de compteur : grisée à zéro.
  static Widget countAvatar(BuildContext context, int count) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 12,
      backgroundColor: count == 0 ? scheme.surfaceContainerHighest : null,
      child: Text(
        count.toString(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: count == 0 ? scheme.outline : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final small = Theme.of(context).textTheme.bodySmall;
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        child: InkWell(
          onTap: onTap,
          child: Column(children: [
            ListTile(
              // Sans jeton, le joueur n'est pas dans l'urne : sa bille est grise.
              leading: CircleAvatar(
                backgroundColor: tokens == 0 ? scheme.surfaceContainerHighest : scheme.primary,
                foregroundColor: tokens == 0 ? scheme.outline : scheme.onPrimary,
                child: Text(number.toString())
              ),
              title: Text(name),
              dense: true
            ),
            ListTile(
              leading: countAvatar(context, sessions),
              title: Text(s.data_session_objName(sessions), style: small),
              dense: true,
              visualDensity: VisualDensity.compact
            ),
            ListTile(
              leading: countAvatar(context, bonus),
              title: Text(s.data_player_bonus, style: small),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bonusButton(Icons.remove, onBonus != null && bonus > 0 ? () => onBonus!(-1) : null),
                  bonusButton(Icons.add, onBonus != null ? () => onBonus!(1) : null),
                ],
              ),
              dense: true,
              visualDensity: VisualDensity.compact
            ),
            ListTile(
              leading: countAvatar(context, tokens),
              title: Text(s.data_player_tokens(tokens), style: small),
              dense: true,
              visualDensity: VisualDensity.compact
            ),
          ])
        )
      ),
    );
  }
}
