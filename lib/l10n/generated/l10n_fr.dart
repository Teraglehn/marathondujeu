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
  String get utils_button_save_and_draw => 'Sauvegarder et Tirer au sort';

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
  String get page_session_manualAdd => 'Mode manuel';

  @override
  String get page_session_manualAddActive => 'Mode manuel - actif';

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
