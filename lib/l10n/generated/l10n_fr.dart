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
  String get data_player_error_name_required => 'Le nom est requis';

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
  String get page_playerList_title => 'Joueurs';

  @override
  String get page_playerList_menuItem => 'Joueurs';

  @override
  String get page_sessionList_title => 'Sessions';

  @override
  String get page_sessionList_menuItem => 'Sessions';

  @override
  String get page_eventList_title => 'Evénements';

  @override
  String get page_eventList_menuItem => 'Evénements';

  @override
  String get page_cardGenerator_title => 'Générateur de Carte';

  @override
  String get page_cardGenerator_menuItem => 'Générateur de Carte';

  @override
  String get widget_eventSelector_selectTitle => 'Sélectionner un évènement';

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
}
