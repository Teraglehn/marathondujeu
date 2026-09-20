import 'package:flutter/material.dart';
import 'package:marathondujeu/l10n/generated/l10n.dart';
import 'package:marathondujeu/src/ui/widgets/help/help_tour.dart';

/// Un pas du tutoriel d'une page : une ou deux phrases, et l'élément visé — aucun pour un pas
/// qui parle de la page entière. Un pas dont la cible n'est pas à l'écran est sauté.
class HelpStep {
  final String text;
  final GlobalKey? target;

  const HelpStep(this.text, {this.target});
}

/// Le « i » de la barre d'une page, toujours en dernier : il lance le pas à pas de cette page.
/// Les pas se construisent à l'ouverture, avec les données du moment — c'est ce qui rend
/// l'aide « maligne » (une liste vide dit où les choses apparaîtront).
class HelpButton extends StatelessWidget {
  final List<HelpStep> Function() steps;

  const HelpButton({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      tooltip: S.of(context).help_button,
      onPressed: () => HelpTour.show(context, steps()),
    );
  }
}

/// Un petit « i » à infobulle, à côté d'un champ ou d'un interrupteur qui demande un mot.
class HelpHint extends StatelessWidget {
  final String text;

  const HelpHint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: text,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(Icons.info_outline, size: 16, color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}
