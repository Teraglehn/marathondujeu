import 'package:marathondujeu/src/data/collections/collections.dart';

/// Ce qu'un scan a fait, ou pourquoi il n'a rien fait. Le texte affiché est celui de la page
/// (`ScanStatus`) ; ici, seulement le fait et ce qu'il faut pour le dire.
sealed class ScanResult {
  const ScanResult();

  /// Rouge dans la barre : le scan n'a rien fait et l'organisateur doit le savoir.
  bool get isError => false;
}

/// La fiche du joueur est ouverte.
class ScanOpened extends ScanResult {
  final Player player;
  const ScanOpened(this.player);
}

class ScanAddedToGroup extends ScanResult {
  final Player player;
  final PlayerGroup group;
  const ScanAddedToGroup(this.player, this.group);
}

class ScanAlreadyInGroup extends ScanResult {
  final Player player;
  final PlayerGroup group;
  const ScanAlreadyInGroup(this.player, this.group);
}

class ScanBadged extends ScanResult {
  final Player player;
  final Session session;
  const ScanBadged(this.player, this.session);
}

/// Scanné deux fois : une information, pas une erreur.
class ScanAlreadyPresent extends ScanResult {
  final Player player;
  final Session session;
  const ScanAlreadyPresent(this.player, this.session);
}

/// Mode suppression : le joueur est retiré de la session, ou n'y était pas (information).
class ScanRemovedFromSession extends ScanResult {
  final Player player;
  final Session session;
  const ScanRemovedFromSession(this.player, this.session);
}

class ScanNotPresent extends ScanResult {
  final Player player;
  final Session session;
  const ScanNotPresent(this.player, this.session);
}

class ScanRemovedFromGroup extends ScanResult {
  final Player player;
  final PlayerGroup group;
  const ScanRemovedFromGroup(this.player, this.group);
}

class ScanNotInGroup extends ScanResult {
  final Player player;
  final PlayerGroup group;
  const ScanNotInGroup(this.player, this.group);
}

class ScanNoOpenSession extends ScanResult {
  const ScanNoOpenSession();
  @override
  bool get isError => true;
}

class ScanSessionNotOpen extends ScanResult {
  final Session session;
  const ScanSessionNotOpen(this.session);
  @override
  bool get isError => true;
}

/// Carte inconnue de l'événement : numéro sans joueur, ou autre édition.
class ScanInvalidCard extends ScanResult {
  const ScanInvalidCard();
  @override
  bool get isError => true;
}

class ScanNoEvent extends ScanResult {
  const ScanNoEvent();
  @override
  bool get isError => true;
}
