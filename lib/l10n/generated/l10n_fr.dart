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
  String get editor_dirty_title => 'Modification en cours';

  @override
  String get editor_dirty_text =>
      'Voulez-vous quitter ? Ce qui a été modifié sera perdu.';

  @override
  String get editor_dirty_stay => 'Revenir';

  @override
  String get editor_dirty_leave => 'Quitter';

  @override
  String editor_event_sessions_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
      zero: 'Aucune session',
    );
    return '$_temp0';
  }

  @override
  String editor_event_sessions_line(Object number, Object start, Object end) {
    return '$number : $start – $end';
  }

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
  String get data_playerGroup_error_name_required => 'Le nom est requis';

  @override
  String get data_playerGroup_kind_winners => 'Groupe de gagnants';

  @override
  String get data_playerGroup_winners_help =>
      'Groupe de gagnants d\'un tirage : il porte le nom du tirage et ne se supprime pas.';

  @override
  String data_playerGroup_usedByDraws(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Utilisé par $count tirages : il ne peut pas être supprimé.',
      one: 'Utilisé par un tirage : il ne peut pas être supprimé.',
    );
    return '$_temp0';
  }

  @override
  String data_playerGroup_delete_confirm(Object name) {
    return 'Supprimer le groupe « $name » ? Ses joueurs ne sont pas supprimés.';
  }

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
  String get data_draw_error_name_required => 'Le nom est requis';

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
  String page_playerList_alreadyExisting(Object count) {
    return 'Déjà $count joueurs existants';
  }

  @override
  String get page_playerGroupsList_title => 'Groupes';

  @override
  String get page_playerGroupsList_menuItem => 'Groupes';

  @override
  String get page_playerGroupsList_help_winners =>
      'Les groupes de gagnants des tirages ne sont pas listés ici : on les retrouve dans le tirage qui les a créés, et dans les choix d\'un tirage.';

  @override
  String get page_playerGroup_title => 'Groupe';

  @override
  String page_playerGroup_members(Object count) {
    return 'Membres ($count)';
  }

  @override
  String get page_playerGroup_addByNumber => 'Ajouter par numéro';

  @override
  String page_playerGroup_alreadyMember(Object number) {
    return 'Numéro $number déjà dans le groupe';
  }

  @override
  String get page_playerGroup_help_removeMode =>
      'Mode suppression : chaque joueur reçoit un bouton Retirer, qui l\'enlève du groupe tout de suite.';

  @override
  String get page_sessionList_title => 'Sessions';

  @override
  String get page_sessionList_menuItem => 'Sessions';

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
  String get page_eventList_empty_title => 'Créer un événement';

  @override
  String get page_eventList_empty_text =>
      'Tout commence par un événement : ses dates, ses sessions, ses joueurs.';

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
  String page_cardGenerator_playerCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count joueurs',
      one: '1 joueur',
      zero: 'Aucun joueur',
    );
    return '$_temp0';
  }

  @override
  String get page_cardGenerator_generateExtraPlayers =>
      'Générer les joueurs supplémentaires';

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
  String get data_event_regenerateSessions_title => 'Recréer les sessions ?';

  @override
  String data_event_regenerateSessions_confirm(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count badgeages',
      one: '1 badgeage',
    );
    return 'Les horaires ont changé : les sessions seront recréées et $_temp0 perdus.';
  }

  @override
  String get data_event_regenerateSessions_revert =>
      'Annuler les modifications';

  @override
  String get data_event_regenerateSessions_recreate => 'Recréer les sessions';

  @override
  String get page_drawList_title => 'Tirages';

  @override
  String get page_drawList_menuItem => 'Tirages';

  @override
  String get widget_eventSelectedGuard_pleaseSelectEvent =>
      'Veuillez sélectionner un événement';

  @override
  String get widget_eventSelectedGuard_chooseEvent => 'Choisir un événement';

  @override
  String get widget_mainRail_createEventFirst => 'Créez d\'abord un événement';

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
  String get scan_hint_openPlayer =>
      'Scanner une carte pour ouvrir la fiche joueur';

  @override
  String get scan_hint_addToGroup =>
      'Scanner une carte pour ajouter le joueur au groupe';

  @override
  String get scan_hint_badgeOpenSession =>
      'Scanner une carte pour badger la session ouverte';

  @override
  String get scan_hint_badgeThisSession =>
      'Scanner une carte pour badger cette session';

  @override
  String get scan_hint_removeFromGroup =>
      'Scanner une carte pour retirer le joueur du groupe';

  @override
  String get scan_hint_removeFromSession =>
      'Scanner une carte pour retirer le joueur de cette session';

  @override
  String scan_removedFromGroup(Object number) {
    return 'Joueur $number retiré du groupe';
  }

  @override
  String scan_notInGroup(Object number) {
    return 'Joueur $number n\'est pas dans le groupe';
  }

  @override
  String scan_removedFromSession(Object number, Object session) {
    return 'Joueur $number retiré de la session $session';
  }

  @override
  String scan_notPresent(Object number, Object session) {
    return 'Joueur $number n\'est pas sur la session $session';
  }

  @override
  String scan_opened(Object number) {
    return 'Joueur $number : fiche ouverte';
  }

  @override
  String scan_addedToGroup(Object number) {
    return 'Joueur $number ajouté au groupe';
  }

  @override
  String scan_alreadyInGroup(Object number) {
    return 'Joueur $number déjà dans le groupe';
  }

  @override
  String scan_badged(Object number, Object session) {
    return 'Joueur $number badgé sur la session $session';
  }

  @override
  String scan_alreadyPresent(Object number, Object session) {
    return 'Joueur $number déjà présent sur la session $session';
  }

  @override
  String get scan_noOpenSession => 'Aucune session ouverte';

  @override
  String get scan_sessionNotOpen => 'La session n\'est pas ouverte';

  @override
  String get scan_invalidCard => 'Carte invalide';

  @override
  String get scan_noEvent => 'Aucun événement sélectionné';

  @override
  String get help_button => 'Aide de la page';

  @override
  String get help_next => 'Suivant';

  @override
  String get help_finish => 'Terminer';

  @override
  String get help_skip => 'Passer';

  @override
  String help_counter(Object index, Object count) {
    return '$index / $count';
  }

  @override
  String get help_hint_playerCount =>
      'Le nombre total de cartes de l\'événement. Augmentez-le pour créer les joueurs qui manquent ; on ne retire pas de joueur ici.';

  @override
  String get help_hint_manualBadge =>
      'Allumé, la douchette et le champ Numéro badgent cette session même hors de son horaire.';

  @override
  String get help_hint_removeMode =>
      'Allumé, un scan ou un numéro retire le joueur au lieu de l\'ajouter.';

  @override
  String get help_hint_sessionNumber =>
      'Sans carte sous la main : tapez le numéro du joueur, puis Entrée.';

  @override
  String get help_hint_groupNumber =>
      'Tapez le numéro d\'un joueur, puis Entrée, pour l\'ajouter sans sa carte.';

  @override
  String get page_playerList_legend =>
      'Jetons = sessions badgées + bonus : les chances du joueur au tirage. Une bille grise n\'a aucun jeton — le joueur n\'est pas dans l\'urne.';

  @override
  String get help_eventList_1 =>
      'Cette page liste vos événements — un par édition du Marathon. Tout le reste de l\'application travaille sur l\'événement choisi en haut à droite.';

  @override
  String get help_eventList_2 =>
      'Créez un événement avec ce bouton : son nom, ses dates, la durée et l\'intervalle des sessions. Les sessions se génèrent d\'elles-mêmes.';

  @override
  String get help_eventList_3 => 'Retrouvez un événement par son nom.';

  @override
  String get help_eventList_4 =>
      'Cliquez un événement pour le modifier : dates, protection des cartes, suppression des joueurs, fichier de sauvegarde. La flèche au bout de la ligne le ferme — son fichier de sauvegarde reste.';

  @override
  String get help_eventList_5 =>
      'Choisissez ici l\'événement sur lequel vous travaillez : joueurs, sessions, tirages et cartes sont les siens.';

  @override
  String get help_eventList_6 =>
      'Où que vous soyez, scanner une carte ouvre la fiche du joueur ; le résultat du dernier scan s\'affiche ici.';

  @override
  String get help_playerList_1 =>
      'Les joueurs sont anonymes : chacun est un numéro de carte. Cette page les crée et suit leurs jetons.';

  @override
  String get help_playerList_2 =>
      'Indiquez combien de cartes vous imprimez, puis « Générer les joueurs manquants » : les numéros absents sont créés.';

  @override
  String get help_playerList_3 =>
      'Une carte par joueur : son numéro, ses sessions badgées, son bonus, ses jetons. Cliquez-la pour ouvrir sa fiche.';

  @override
  String get help_playerList_3_empty =>
      'Les joueurs apparaîtront ici, une carte chacun, dès que vous les aurez générés.';

  @override
  String get help_playerList_4 =>
      '« + » et « − » sur la ligne Bonus offrent ou retirent des sessions : un jeton de plus ou de moins au tirage.';

  @override
  String get help_playerList_5 =>
      'Jetons = sessions + bonus : les chances du joueur au tirage. Une bille grise n\'a aucun jeton.';

  @override
  String get help_playerList_6 =>
      'Scanner une carte ouvre la fiche de ce joueur.';

  @override
  String get help_playerGroupList_1 =>
      'Un groupe rassemble des joueurs pour les tirages, et rien d\'autre : un tirage peut exiger ou exclure ses membres.';

  @override
  String get help_playerGroupList_2 =>
      'Créez un groupe : un nom suffit. Les joueurs s\'ajoutent ensuite sur sa page.';

  @override
  String get help_playerGroupList_3 =>
      'Cliquez un groupe pour ouvrir sa page ; le crayon le renomme, la poubelle le supprime (ses joueurs restent).';

  @override
  String get help_playerGroupList_3_empty => 'Vos groupes apparaîtront ici.';

  @override
  String get help_playerGroupList_4 =>
      'Les groupes de gagnants ne sont pas listés : ils vivent dans le tirage qui les a créés.';

  @override
  String get help_playerGroupList_5 =>
      'Ici, scanner une carte ouvre la fiche du joueur. Sur la page d\'un groupe, elle l\'y ajoute.';

  @override
  String get help_playerGroup_1 =>
      'La page d\'un groupe : ses membres, et comment en ajouter ou en retirer.';

  @override
  String get help_playerGroup_2 =>
      'Scannez la carte d\'un joueur : il rejoint le groupe. Déjà membre, rien ne change.';

  @override
  String get help_playerGroup_3 =>
      'Sans carte : tapez son numéro, puis Entrée ou « Ajouter ».';

  @override
  String get help_playerGroup_4 =>
      'Mode suppression : un scan ou un numéro retire le joueur, et chaque bille reçoit un bouton « Retirer ».';

  @override
  String get help_playerGroup_5 => 'Les membres du groupe, par numéro.';

  @override
  String get help_playerGroup_6 =>
      'Le crayon renomme le groupe, ou le supprime.';

  @override
  String get help_sessionList_1 =>
      'Une session est un créneau de badgeage. Les joueurs présents scannent leur carte : chaque session badgée vaut un jeton au tirage.';

  @override
  String get help_sessionList_2 =>
      'L\'heure de l\'application : c\'est elle qui décide quelle session est ouverte.';

  @override
  String get help_sessionList_3_open =>
      'La session ouverte est en couleur : c\'est là que la douchette badge maintenant. Cliquez une carte pour ouvrir sa session.';

  @override
  String get help_sessionList_3_closed =>
      'Aucune session n\'est ouverte à cette heure : la douchette ne badge pas. Cliquez une carte pour ouvrir une session et badger à la main.';

  @override
  String get help_sessionList_3_empty =>
      'Les sessions se génèrent depuis l\'événement : ses dates, la durée et l\'intervalle des sessions.';

  @override
  String get help_sessionList_4 =>
      'Depuis cette page, scanner une carte badge la session ouverte, sans l\'ouvrir.';

  @override
  String get help_sessionList_5 =>
      'Les couleurs : ouverte, passée, à venir. « n présents » compte les joueurs badgés.';

  @override
  String get help_session_1 =>
      'La page d\'une session : qui est là, qui manque, et les moyens de badger.';

  @override
  String get help_session_2 =>
      'Le créneau, son état (ouverte, passée) et l\'heure.';

  @override
  String get help_session_3 =>
      'Scannez une carte : le joueur passe dans Présents. Hors de l\'horaire, le scan est refusé — sauf en badgeage manuel.';

  @override
  String get help_session_4 =>
      'Badgeage manuel : pour badger hors de l\'horaire — un retardataire, une session passée.';

  @override
  String get help_session_5 =>
      'Sans carte : le numéro du joueur, puis Entrée ou « Ajouter ».';

  @override
  String get help_session_6 =>
      'Mode suppression : un scan, un numéro ou le bouton « Retirer » d\'une bille enlève le joueur de la session.';

  @override
  String get help_session_7 =>
      'Présents : les joueurs badgés sur cette session.';

  @override
  String get help_session_8 =>
      'Absents : ceux qui ont badgé une autre session, mais pas celle-ci. Un joueur jamais badgé n\'apparaît pas.';

  @override
  String get help_session_9 => 'Retour à la liste des sessions.';

  @override
  String get help_drawList_1 =>
      'Un tirage tire au sort des gagnants parmi les joueurs : plus un joueur a de jetons, plus il a de chances.';

  @override
  String get help_drawList_2 =>
      'Créez un tirage : nombre de gagnants, sessions et groupes requis ou exclus, puis « Tirer au sort ».';

  @override
  String get help_drawList_3 =>
      'Cliquez un tirage pour le consulter ou le modifier.';

  @override
  String get help_drawList_3_empty =>
      'Vos tirages apparaîtront ici, avec leurs gagnants.';

  @override
  String get help_drawList_3_drawn =>
      'Un cadenas : le tirage est fait, il ne se modifie plus. Ses gagnants sont affichés ; cliquez-en un pour ouvrir sa fiche.';

  @override
  String get help_drawList_4 =>
      'Copier reprend les réglages d\'un tirage dans un nouveau — pour retirer avec les mêmes règles.';

  @override
  String get help_drawList_5 => 'Scanner une carte ouvre la fiche du joueur.';

  @override
  String get help_cardGenerator_1 =>
      'Cette page prépare les cartes à imprimer : une image de fond, le code de chaque joueur, son numéro.';

  @override
  String get help_cardGenerator_2 =>
      'Choisissez l\'image de fond en cliquant le cadre. La hauteur des cartes suit ses proportions.';

  @override
  String get help_cardGenerator_3 =>
      'La planche : combien de cartes par ligne et par page, leur largeur, les marges.';

  @override
  String get help_cardGenerator_4 =>
      'Le code de la carte : sa taille et sa position, en millimètres depuis le coin haut gauche.';

  @override
  String get help_cardGenerator_5 =>
      'Le numéro : même chose, plus la police et la couleur.';

  @override
  String get help_cardGenerator_6 =>
      'Du numéro… au numéro… : les cartes à imprimer. Au-delà des joueurs existants, un bouton les crée.';

  @override
  String get help_cardGenerator_7 =>
      'L\'aperçu rapide suit vos réglages ; l\'aperçu PDF est ce qui s\'imprime, avec son bouton d\'impression.';

  @override
  String get help_cardGenerator_8 =>
      'Enregistrez : les réglages sont gardés avec l\'événement.';

  @override
  String get help_guide_menuItem => 'Guide';

  @override
  String get help_guide_title => 'Guide — le parcours d\'une édition';

  @override
  String get help_guide_intro =>
      'Une édition du Marathon se joue en six temps, dans l\'ordre des pages du rail de gauche. Chaque page a son « i » en haut à droite pour le détail.';

  @override
  String get help_guide_where_title => 'Où trouver l\'aide';

  @override
  String get help_guide_where_hint =>
      'Un petit « i » à côté d\'un champ ou d\'un interrupteur : passez la souris dessus, une phrase l\'explique.';

  @override
  String get help_guide_where_legend =>
      'Un texte dans l\'écran, sous une liste ou un formulaire : la légende de ce que vous voyez.';

  @override
  String get help_guide_where_tour =>
      'Le « i » en haut à droite de chaque page : un pas à pas sur l\'écran, zone par zone.';

  @override
  String get help_guide_step_1_title => 'Créez l\'événement';

  @override
  String get help_guide_step_1_text =>
      'Nom, début, fin, durée et intervalle des sessions : l\'aperçu montre les sessions qui seront créées, elles se génèrent d\'elles-mêmes. Choisissez-lui un fichier de sauvegarde : l\'application le réécrit à chaque modification, et « Ouvrir un fichier de sauvegarde » retrouve l\'événement entier sur un autre poste. Choisissez ensuite cet événement en haut à droite des autres pages.';

  @override
  String get help_guide_step_2_title => 'Générez les joueurs';

  @override
  String get help_guide_step_2_text =>
      'Indiquez combien de cartes vous imprimez : un joueur par numéro, anonyme. Chaque joueur cumule des jetons — ses chances au tirage.';

  @override
  String get help_guide_step_3_title => 'Imprimez les cartes';

  @override
  String get help_guide_step_3_text =>
      'Dans le Générateur de carte : une image de fond, le code et le numéro placés dessus, puis l\'impression. Chaque joueur reçoit sa carte.';

  @override
  String get help_guide_step_4_title => 'Badgez à chaque session';

  @override
  String get help_guide_step_4_text =>
      'Pendant la session ouverte (en couleur), les joueurs présents scannent leur carte : un jeton par session badgée.';

  @override
  String get help_guide_step_5_title => 'Rassemblez des joueurs (facultatif)';

  @override
  String get help_guide_step_5_text =>
      'Un groupe sert aux tirages, et à rien d\'autre : un tirage peut exiger ou exclure ses membres.';

  @override
  String get help_guide_step_6_title => 'Tirez au sort';

  @override
  String get help_guide_step_6_text =>
      'Nombre de gagnants, sessions ou groupes requis ou exclus, puis « Tirer au sort » : plus un joueur a de jetons, plus il a de chances. Les gagnants s\'affichent, le tirage se verrouille.';

  @override
  String help_guide_open(Object page) {
    return 'Ouvrir la page $page';
  }

  @override
  String get help_guide_sample_event => 'Marathon du Jeu 2026';

  @override
  String get help_guide_sample_group => 'Les habitués';

  @override
  String get backup_title => 'Fichier de sauvegarde';

  @override
  String get backup_help =>
      'L\'application réécrit ce fichier toute seule à chaque modification : joueurs, badgeages, groupes, tirages, image des cartes. Gardez-le dans un dossier synchronisé ou sur une clé : il permet de retrouver l\'événement sur un autre poste.';

  @override
  String get backup_none =>
      'Aucun fichier : cet événement n\'est pas sauvegardé.';

  @override
  String get backup_choose => 'Choisir…';

  @override
  String get backup_remove => 'Retirer';

  @override
  String backup_lastWritten(Object time) {
    return 'Dernière sauvegarde à $time';
  }

  @override
  String get backup_notYetWritten =>
      'Pas encore écrit — à la prochaine modification, ou à l\'enregistrement.';

  @override
  String backup_suggestedName(Object name) {
    return '$name.marathon.json';
  }

  @override
  String backup_writeError(Object name) {
    return 'Sauvegarde impossible pour « $name » : vérifiez le dossier du fichier.';
  }

  @override
  String backup_pathLost(Object name) {
    return 'Le dossier du fichier de sauvegarde de « $name » n\'existe plus : choisissez-en un nouveau dans l\'événement.';
  }

  @override
  String get backup_open => 'Ouvrir un fichier de sauvegarde';

  @override
  String backup_opened(Object name) {
    return 'Événement « $name » ajouté';
  }

  @override
  String backup_replaced(Object name) {
    return 'Événement « $name » remplacé';
  }

  @override
  String get backup_unreadable =>
      'Ce fichier n\'est pas un fichier de sauvegarde lisible.';

  @override
  String get backup_exists_title => 'Cet événement est déjà là';

  @override
  String backup_exists_text(Object name) {
    return '« $name » est déjà dans la liste. Le remplacer par le contenu du fichier ? Ce qui a été fait depuis dans l\'application sera perdu.';
  }

  @override
  String get backup_replace => 'Remplacer';

  @override
  String get help_eventList_7 =>
      'Ouvrez un fichier de sauvegarde pour retrouver un événement — après un poste mort, ou venu d\'un autre poste. Chaque événement choisit son fichier dans son éditeur.';

  @override
  String get event_close => 'Fermer l\'événement';

  @override
  String event_close_title(Object name) {
    return 'Fermer « $name » ?';
  }

  @override
  String event_close_saved_text(Object path) {
    return 'Son fichier de sauvegarde reste : $path. « Ouvrir un fichier de sauvegarde » le ramènera.';
  }

  @override
  String get event_close_unsaved_title => 'Cet événement n\'est pas sauvegardé';

  @override
  String event_close_unsaved_text(Object name) {
    return '« $name » et toutes ses données — joueurs, badgeages, groupes, tirages — seront perdus. Choisissez d\'abord un fichier de sauvegarde, ou fermez quand même.';
  }

  @override
  String get event_close_confirm => 'Fermer';

  @override
  String get event_close_anyway => 'Fermer quand même';

  @override
  String event_closed(Object name) {
    return 'Événement « $name » fermé';
  }

  @override
  String event_closed_saved(Object name, Object path) {
    return 'Événement « $name » fermé — son fichier de sauvegarde : $path';
  }
}
