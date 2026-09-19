// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SFr extends S {
  SFr([String locale = 'fr']) : super(locale);

  @override
  String get app_title => 'Marathon du Jeu';

  @override
  String get utils_searchField_label => 'Recherche';

  @override
  String get utils_button_cancel => 'Annuler';

  @override
  String get utils_button_save => 'Enregistrer';

  @override
  String get utils_button_saveAll => 'Tout enregistrer';

  @override
  String utils_button_saveNItems(Object count, Object objName) {
    return 'Enregistrer $count $objName';
  }

  @override
  String get utils_button_delete => 'Supprimer';

  @override
  String get utils_button_deleteAll => 'Tout supprimer';

  @override
  String utils_button_deleteNItems(Object count, Object objName) {
    return 'Supprimer $count $objName';
  }

  @override
  String get utils_button_add => 'Ajouter';

  @override
  String get utils_button_edit => 'Modifier';

  @override
  String get utils_button_select => 'Sélectionner';

  @override
  String get utils_button_select_all => 'Sélectionner Tout';

  @override
  String get utils_button_deselect_all => 'Désélectionner Tout';

  @override
  String get utils_button_close => 'Fermer';

  @override
  String get editor_title_player => 'Modifier un joueur';

  @override
  String get editor_title_event_create => 'Créer un événement';

  @override
  String get editor_title_event_edit => 'Modifier un événement';

  @override
  String get editor_title_playerGroup_create => 'Créer un groupe de joueurs';

  @override
  String get editor_title_playerGroup_edit => 'Modifier un groupe de joueurs';

  @override
  String get editor_title_draw_create => 'Créer un tirage';

  @override
  String get editor_title_draw_edit => 'Modifier un tirage';

  @override
  String get editor_title_draw_view => 'Consulter un tirage';

  @override
  String get utils_button_reset => 'Réinitialiser';

  @override
  String get utils_icon_filled => 'Rempli';

  @override
  String get utils_icon_outlined => 'Contour';

  @override
  String get utils_icon_rounded => 'Arrondi';

  @override
  String get utils_icon_sharp => 'Pointu';

  @override
  String data_player_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Joueurs',
      one: 'Joueur',
    );
    return '$_temp0';
  }

  @override
  String get data_player_name => 'Nom';

  @override
  String get data_player_qrcode => 'QRCode';

  @override
  String get data_player_number => 'Numéro';

  @override
  String get data_player_bonus => 'Bonus';

  @override
  String data_player_tokens(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jetons',
      one: 'Jeton',
    );
    return '$_temp0';
  }

  @override
  String get data_player_error_name_required => 'Le nom est requis';

  @override
  String get data_player_error_qrCode_required => 'QRCode est requis';

  @override
  String data_playerGroup_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Groupes',
      one: 'Groupe',
    );
    return '$_temp0';
  }

  @override
  String get data_playerGroup_name => 'Nom';

  @override
  String get data_playerGroup_error_name_required => 'Nom is required';

  @override
  String data_draw_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tirages',
      one: 'Tirage',
    );
    return '$_temp0';
  }

  @override
  String get data_draw_name => 'Nom';

  @override
  String get data_draw_minSessionNumber => 'Nombre mini de session';

  @override
  String get data_draw_maxSessionNumber => 'Nombre maxi de sessions';

  @override
  String get data_draw_excludedSessions => 'Session exclue';

  @override
  String get data_draw_requiredSessions => 'Session requises';

  @override
  String get data_draw_excludedPlayers => 'Joueur exclus';

  @override
  String get data_draw_requiredPlayers => 'Joueurs requis';

  @override
  String get data_draw_winnerCount => 'Nombre de gagnant à tirer au sort';

  @override
  String data_draw_playerCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Joueurs',
      one: 'Joueur',
    );
    return '$_temp0 selectionnés pour le tirage';
  }

  @override
  String get data_draw_error_name_required => 'Nom est requis';

  @override
  String data_draw_tokenCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jetons dans l\'urne',
      one: '1 jeton dans l\'urne',
      zero: 'Aucun jeton dans l\'urne',
    );
    return '$_temp0';
  }

  @override
  String get data_draw_eligibility_help =>
      'Seuls les joueurs qui ont au moins un jeton comptent. Chaque jeton est une chance au tirage.';

  @override
  String data_draw_excludedPlayers_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count joueurs exclus individuellement',
      one: '1 joueur exclu individuellement',
      zero: 'Aucun joueur exclu individuellement',
    );
    return '$_temp0';
  }

  @override
  String data_draw_drawnAt(Object date) {
    return 'Tiré le $date';
  }

  @override
  String get data_draw_drawn => 'Tiré';

  @override
  String get data_draw_drawn_help =>
      'Ce tirage a été effectué : il ne se modifie plus et ne se relance pas. Pour recommencer, copiez-le.';

  @override
  String get data_draw_copy => 'Copier';

  @override
  String get data_draw_copy_help =>
      'La copie reprend les mêmes réglages et exclut les gagnants de ce tirage.';

  @override
  String get data_draw_launch => 'Tirer au sort';

  @override
  String data_draw_launch_confirm(Object winners, Object players) {
    return 'Tirer au sort $winners gagnants parmi $players joueurs ? Un tirage ne se lance qu\'une fois.';
  }

  @override
  String data_event_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Evénements',
      one: 'Evénement',
    );
    return '$_temp0';
  }

  @override
  String get data_event_name => 'Nom';

  @override
  String get data_event_datetime_start => 'Début';

  @override
  String get data_event_datetime_end => 'Fin';

  @override
  String get data_event_session_duration_minute => 'Durée de session (min)';

  @override
  String get data_event_session_interval_minute => 'Interval de session (min)';

  @override
  String get data_event_error_name_required => 'Le nom est requis';

  @override
  String get data_event_error_datetime_start_required => 'Le début est requis';

  @override
  String get data_event_error_datetime_end_required => 'La fin est requise';

  @override
  String get data_event_error_session_duration_minute_required =>
      'La durée de session est requise';

  @override
  String get data_event_error_session_interval_minute_required =>
      'L\'interval de session est requis';

  @override
  String data_session_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sessions',
      one: 'Session',
    );
    return '$_temp0';
  }

  @override
  String get page_playerList_title => 'Joueurs';

  @override
  String get page_playerList_menuItem => 'Joueurs';

  @override
  String get page_playerList_playerCount => 'Nombre de joueurs';

  @override
  String get page_playerList_generateMissingPlayers =>
      'Générer les joueurs manquants';

  @override
  String get page_playerList_deletePlayers => 'Supprimer les joueurs';

  @override
  String get page_playerGroupsList_title => 'Groupes';

  @override
  String get page_playerGroupsList_menuItem => 'Groupes';

  @override
  String get page_playerGroup_title => 'Groupe';

  @override
  String get page_sessionList_title => 'Sessions';

  @override
  String get page_sessionList_menuItem => 'Sessions';

  @override
  String get page_sessionList_generateSessions => 'Générer les sessions';

  @override
  String get page_sessionList_deleteSessions => 'Supprimer les sessions';

  @override
  String get page_session_title => 'Session';

  @override
  String get page_session_manualAdd => 'Badgeage manuel';

  @override
  String page_session_header(Object end, Object number, Object start) {
    return 'Session $number — $start à $end';
  }

  @override
  String get page_session_state_open => 'Ouverte';

  @override
  String get page_session_state_past => 'Passée';

  @override
  String page_session_zone_present(Object count) {
    return 'Présents ($count)';
  }

  @override
  String page_session_zone_absent(Object count) {
    return 'Absents ($count)';
  }

  @override
  String get page_session_removeMode => 'Mode suppression';

  @override
  String get page_session_remove => 'Retirer';

  @override
  String get page_session_number => 'Numéro';

  @override
  String page_session_number_unknown(Object number) {
    return 'Numéro $number inconnu';
  }

  @override
  String get page_session_help_absent =>
      'Absent : a badgé une autre session, pas celle-ci. Les joueurs qui n\'ont encore badgé aucune session n\'apparaissent pas.';

  @override
  String get page_session_help_removeMode =>
      'Mode suppression : chaque joueur présent reçoit un bouton Retirer, qui l\'enlève de la session tout de suite.';

  @override
  String get page_sessionList_legend_open =>
      'Ouverte : on peut y badger maintenant';

  @override
  String get page_sessionList_legend_past => 'Passée';

  @override
  String get page_sessionList_legend_upcoming => 'À venir';

  @override
  String page_sessionList_present(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'présents',
      one: 'présent',
    );
    return '$_temp0';
  }

  @override
  String get form_player_bonus_help =>
      'Chaque point bonus ajoute un jeton pour les tirages au sort';

  @override
  String get form_player_legend_present =>
      'Présent : le joueur a badgé cette session';

  @override
  String get form_player_legend_absent =>
      'Absent : le joueur n\'a pas badgé cette session';

  @override
  String get form_player_legend_manual =>
      'Badgeage manuel : cliquer une session pour marquer le joueur présent ou absent, puis Enregistrer';

  @override
  String get page_eventList_title => 'Evénements';

  @override
  String get page_eventList_menuItem => 'Evénements';

  @override
  String get page_eventList_generateSessions =>
      'Générer les sessions (supprime les sessions existantes)';

  @override
  String get page_cardGenerator_title => 'Générateur de Carte';

  @override
  String get page_cardGenerator_menuItem => 'Générateur de Carte';

  @override
  String get page_cardGenerator_noImage =>
      'Choisissez une image de fond pour voir l\'aperçu des cartes.';

  @override
  String get page_cardGenerator_image => 'Image de fond';

  @override
  String get page_cardGenerator_section_sheet => 'Planche';

  @override
  String get page_cardGenerator_cardsPerRow => 'Cartes par ligne';

  @override
  String get page_cardGenerator_rowsPerPage => 'Lignes par page';

  @override
  String get page_cardGenerator_portrait => 'Portrait';

  @override
  String get page_cardGenerator_landscape => 'Paysage';

  @override
  String get page_cardGenerator_cardWidth => 'Largeur de carte (mm)';

  @override
  String page_cardGenerator_cardHeight(Object mm) {
    return 'Hauteur : $mm mm, selon l\'image';
  }

  @override
  String get page_cardGenerator_pageMargin => 'Marge de page (mm)';

  @override
  String get page_cardGenerator_gapX => 'Espace entre cartes (mm)';

  @override
  String get page_cardGenerator_gapY => 'Espace entre lignes (mm)';

  @override
  String get page_cardGenerator_pageBackgroundColor =>
      'Couleur de fond de la page';

  @override
  String get page_cardGenerator_section_qrCode => 'QR code';

  @override
  String get page_cardGenerator_section_number => 'Numéro de carte';

  @override
  String get page_cardGenerator_size => 'Taille (mm)';

  @override
  String get page_cardGenerator_posX => 'Position X (mm)';

  @override
  String get page_cardGenerator_posY => 'Position Y (mm)';

  @override
  String get page_cardGenerator_fontSize => 'Taille de police (pt)';

  @override
  String get page_cardGenerator_color => 'Couleur';

  @override
  String get page_cardGenerator_background => 'Fond';

  @override
  String get page_cardGenerator_backgroundColor => 'Couleur du fond';

  @override
  String get page_cardGenerator_padding => 'Marge du fond (mm)';

  @override
  String get page_cardGenerator_help_positions =>
      'Les positions se comptent en mm depuis le coin haut-gauche de la carte.';

  @override
  String get page_cardGenerator_section_range => 'Cartes à imprimer';

  @override
  String get page_cardGenerator_from => 'Du numéro';

  @override
  String get page_cardGenerator_to => 'Au numéro';

  @override
  String page_cardGenerator_summary(
    Object count,
    Object start,
    Object end,
    num pages,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages pages',
      one: '1 page',
    );
    return '$count cartes, du numéro $start au numéro $end, sur $_temp0. La dernière feuille est toujours complète.';
  }

  @override
  String get page_cardGenerator_saved => 'Réglages enregistrés';

  @override
  String get page_cardGenerator_quickPreview => 'Aperçu rapide';

  @override
  String get page_cardGenerator_pdfPreview => 'Aperçu PDF';

  @override
  String get page_cardGenerator_quickPreview_help =>
      'Première page seulement, rendu approximatif. L\'aperçu PDF montre toutes les pages telles qu\'elles s\'impriment.';

  @override
  String get data_event_protectCards =>
      'Protéger les cartes contre la copie et la réutilisation';

  @override
  String get data_event_protectCards_help =>
      'Un code secret propre à cet événement est ajouté dans le QR code des cartes : une carte d\'une autre édition n\'est pas reconnue.';

  @override
  String get data_event_protectCards_locked =>
      'Des joueurs existent déjà : la protection ne peut plus changer.';

  @override
  String get data_event_recoverSalt =>
      'Récupérer la protection depuis une carte imprimée';

  @override
  String get data_event_recoverSalt_scan =>
      'Scannez une carte imprimée avec la douchette…';

  @override
  String get data_event_recoverSalt_none =>
      'Cette carte n\'a pas de protection.';

  @override
  String data_event_deletePlayers_confirm(Object count) {
    return 'Supprimer les $count joueurs de cet événement ? Leurs badgeages et les gagnants des tirages seront perdus. Les cartes imprimées ne seront plus reconnues tant que les joueurs ne sont pas regénérés.';
  }

  @override
  String get page_drawList_title => 'Tirages';

  @override
  String get page_drawList_menuItem => 'Tirages';

  @override
  String get widget_eventSelectedGuard_pleaseSelectEvent =>
      'Veuillez selectionner un évènement';

  @override
  String get widget_eventSelector_selectTitle => 'Sélectionner un évènement';

  @override
  String get widget_playerGroupSelector_selectTitle => 'Sélectionner un groupe';

  @override
  String get widget_colorSelector_selectTitle => 'Sélectionner une couleur';

  @override
  String get widget_iconSelector_selectTitle => 'Sélectionner une icône';

  @override
  String get loading_error => 'Erreur de chargement';

  @override
  String get save_failed => 'Échec de l\'enregistrement';

  @override
  String get save_successful => 'Enregistré avec succès';

  @override
  String get delete_failed => 'Échec de la suppression';

  @override
  String get delete_successful => 'Supprimé avec succès';

  @override
  String message_player_scanned(Object pnumber) {
    return 'Joueur $pnumber a été scanné';
  }
}
