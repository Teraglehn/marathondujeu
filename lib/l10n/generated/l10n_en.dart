// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Marathon du Jeu';

  @override
  String get utils_searchField_label => 'Search';

  @override
  String get utils_button_cancel => 'Cancel';

  @override
  String get utils_button_save => 'Save';

  @override
  String get utils_button_saveAll => 'Save All';

  @override
  String utils_button_saveNItems(Object count, Object objName) {
    return 'Save $count $objName';
  }

  @override
  String get utils_button_delete => 'Delete';

  @override
  String get utils_button_deleteAll => 'Delete All';

  @override
  String utils_button_deleteNItems(Object count, Object objName) {
    return 'Delete $count $objName';
  }

  @override
  String get utils_button_add => 'Add';

  @override
  String get utils_button_edit => 'Edit';

  @override
  String get utils_button_select => 'Select';

  @override
  String get utils_button_select_all => 'Select All';

  @override
  String get utils_button_deselect_all => 'Deselect All';

  @override
  String get utils_button_close => 'Close';

  @override
  String get editor_title_player => 'Edit a player';

  @override
  String get editor_title_event_create => 'Create an event';

  @override
  String get editor_title_event_edit => 'Edit an event';

  @override
  String get editor_title_playerGroup_create => 'Create a player group';

  @override
  String get editor_title_playerGroup_edit => 'Edit a player group';

  @override
  String get editor_title_draw_create => 'Create a draw';

  @override
  String get editor_title_draw_edit => 'Edit a draw';

  @override
  String get editor_title_draw_view => 'View a draw';

  @override
  String get editor_dirty_title => 'Unsaved changes';

  @override
  String get editor_dirty_text =>
      'Do you want to leave? What was changed will be lost.';

  @override
  String get editor_dirty_stay => 'Go back';

  @override
  String get editor_dirty_leave => 'Leave';

  @override
  String get utils_button_reset => 'Reset';

  @override
  String get utils_icon_filled => 'Filled';

  @override
  String get utils_icon_outlined => 'Outlined';

  @override
  String get utils_icon_rounded => 'Rounded';

  @override
  String get utils_icon_sharp => 'Sharp';

  @override
  String data_player_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Players',
      one: 'Player',
    );
    return '$_temp0';
  }

  @override
  String get data_player_name => 'Name';

  @override
  String get data_player_qrcode => 'QRCode';

  @override
  String get data_player_number => 'Number';

  @override
  String get data_player_bonus => 'Bonus';

  @override
  String data_player_tokens(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tokens',
      one: 'Token',
    );
    return '$_temp0';
  }

  @override
  String get data_player_error_name_required => 'Name is required';

  @override
  String get data_player_error_qrCode_required => 'QrCode is required';

  @override
  String data_playerGroup_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Groups',
      one: 'Group',
    );
    return 'Player $_temp0';
  }

  @override
  String get data_playerGroup_name => 'Name';

  @override
  String get data_playerGroup_error_name_required => 'Name is required';

  @override
  String data_draw_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Draws',
      one: 'Draw',
    );
    return '$_temp0';
  }

  @override
  String get data_draw_name => 'Name';

  @override
  String get data_draw_minSessionNumber => 'Min number of session';

  @override
  String get data_draw_maxSessionNumber => 'Max number of session';

  @override
  String get data_draw_excludedSessions => 'Excluded sessions';

  @override
  String get data_draw_requiredSessions => 'Required sessions';

  @override
  String get data_draw_excludedPlayers => 'Excluded players';

  @override
  String get data_draw_requiredPlayers => 'Required players';

  @override
  String get data_draw_winnerCount => 'Number of winners to draw';

  @override
  String data_draw_playerCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Players',
      one: 'Player',
    );
    return '$_temp0 selected for drawing lots';
  }

  @override
  String get data_draw_error_name_required => 'Name is required';

  @override
  String data_draw_tokenCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tokens in the urn',
      one: '1 token in the urn',
      zero: 'No token in the urn',
    );
    return '$_temp0';
  }

  @override
  String get data_draw_eligibility_help =>
      'Only players with at least one token count. Each token is one chance in the draw.';

  @override
  String data_draw_excludedPlayers_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count individually excluded players',
      one: '1 individually excluded player',
      zero: 'No individually excluded player',
    );
    return '$_temp0';
  }

  @override
  String data_draw_drawnAt(Object date) {
    return 'Drawn on $date';
  }

  @override
  String get data_draw_drawn => 'Drawn';

  @override
  String get data_draw_drawn_help =>
      'This draw has been made: it can no longer be edited or relaunched. To start again, copy it.';

  @override
  String get data_draw_copy => 'Copy';

  @override
  String get data_draw_copy_help =>
      'The copy keeps the same settings and excludes this draw\'s winners.';

  @override
  String get data_draw_launch => 'Draw';

  @override
  String data_draw_launch_confirm(Object winners, Object players) {
    return 'Draw $winners winners among $players players? A draw is launched only once.';
  }

  @override
  String data_event_objName(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Events',
      one: 'Event',
    );
    return '$_temp0';
  }

  @override
  String get data_event_name => 'Name';

  @override
  String get data_event_datetime_start => 'Start time';

  @override
  String get data_event_datetime_end => 'End time';

  @override
  String get data_event_session_duration_minute => 'Session duration (min)';

  @override
  String get data_event_session_interval_minute => 'Session interval (min)';

  @override
  String get data_event_error_name_required => 'Name is required';

  @override
  String get data_event_error_datetime_start_required =>
      'Start time is required';

  @override
  String get data_event_error_datetime_end_required => 'End time is required';

  @override
  String get data_event_error_session_duration_minute_required =>
      'Session duration is required';

  @override
  String get data_event_error_session_interval_minute_required =>
      'Session interval is required';

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
  String get page_playerList_title => 'Players';

  @override
  String get page_playerList_menuItem => 'Players';

  @override
  String get page_playerList_playerCount => 'Players count';

  @override
  String get page_playerList_generateMissingPlayers =>
      'Generate missing players';

  @override
  String get page_playerList_deletePlayers => 'Delete players';

  @override
  String get page_playerGroupsList_title => 'Player Groups';

  @override
  String get page_playerGroupsList_menuItem => 'Player Groups';

  @override
  String get page_playerGroup_title => 'Player Group';

  @override
  String get page_sessionList_title => 'Sessions';

  @override
  String get page_sessionList_menuItem => 'Sessions';

  @override
  String get page_sessionList_generateSessions => 'Generate sessions';

  @override
  String get page_sessionList_deleteSessions => 'Delete sessions';

  @override
  String get page_session_title => 'Session';

  @override
  String get page_session_manualAdd => 'Manual badging';

  @override
  String page_session_header(Object end, Object number, Object start) {
    return 'Session $number — $start to $end';
  }

  @override
  String get page_session_state_open => 'Open';

  @override
  String get page_session_state_past => 'Past';

  @override
  String page_session_zone_present(Object count) {
    return 'Present ($count)';
  }

  @override
  String page_session_zone_absent(Object count) {
    return 'Absent ($count)';
  }

  @override
  String get page_session_removeMode => 'Removal mode';

  @override
  String get page_session_remove => 'Remove';

  @override
  String get page_session_number => 'Number';

  @override
  String page_session_number_unknown(Object number) {
    return 'Unknown number $number';
  }

  @override
  String get page_session_help_absent =>
      'Absent: badged another session, not this one. Players who have not badged any session yet are not shown.';

  @override
  String get page_session_help_removeMode =>
      'Removal mode: each present player gets a Remove button, which takes them off the session right away.';

  @override
  String get page_sessionList_legend_open => 'Open: badging is possible now';

  @override
  String get page_sessionList_legend_past => 'Past';

  @override
  String get page_sessionList_legend_upcoming => 'Upcoming';

  @override
  String page_sessionList_present(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'present',
      one: 'present',
    );
    return '$_temp0';
  }

  @override
  String get form_player_bonus_help =>
      'Each bonus point adds one token for the draws';

  @override
  String get form_player_legend_present =>
      'Present: the player badged this session';

  @override
  String get form_player_legend_absent =>
      'Absent: the player did not badge this session';

  @override
  String get form_player_legend_manual =>
      'Manual badging: click a session to mark the player present or absent, then Save';

  @override
  String get page_eventList_title => 'Events';

  @override
  String get page_eventList_menuItem => 'Events';

  @override
  String get page_eventList_generateSessions =>
      'Generate sessions (deletes existing sessions)';

  @override
  String get page_eventList_empty_title => 'Create an event';

  @override
  String get page_eventList_empty_text =>
      'Everything starts with an event: its dates, its sessions, its players.';

  @override
  String get page_cardGenerator_title => 'Card Generator';

  @override
  String get page_cardGenerator_menuItem => 'Card Generator';

  @override
  String get page_cardGenerator_noImage =>
      'Choose a background image to preview the cards.';

  @override
  String get page_cardGenerator_image => 'Background image';

  @override
  String get page_cardGenerator_section_sheet => 'Sheet';

  @override
  String get page_cardGenerator_cardsPerRow => 'Cards per row';

  @override
  String get page_cardGenerator_rowsPerPage => 'Rows per page';

  @override
  String get page_cardGenerator_portrait => 'Portrait';

  @override
  String get page_cardGenerator_landscape => 'Landscape';

  @override
  String get page_cardGenerator_cardWidth => 'Card width (mm)';

  @override
  String page_cardGenerator_cardHeight(Object mm) {
    return 'Height: $mm mm, from the image';
  }

  @override
  String get page_cardGenerator_pageMargin => 'Page margin (mm)';

  @override
  String get page_cardGenerator_gapX => 'Gap between cards (mm)';

  @override
  String get page_cardGenerator_gapY => 'Gap between rows (mm)';

  @override
  String get page_cardGenerator_pageBackgroundColor => 'Page background colour';

  @override
  String get page_cardGenerator_section_qrCode => 'QR code';

  @override
  String get page_cardGenerator_section_number => 'Card number';

  @override
  String get page_cardGenerator_size => 'Size (mm)';

  @override
  String get page_cardGenerator_posX => 'X position (mm)';

  @override
  String get page_cardGenerator_posY => 'Y position (mm)';

  @override
  String get page_cardGenerator_fontSize => 'Font size (pt)';

  @override
  String get page_cardGenerator_color => 'Colour';

  @override
  String get page_cardGenerator_background => 'Background';

  @override
  String get page_cardGenerator_backgroundColor => 'Background colour';

  @override
  String get page_cardGenerator_padding => 'Background padding (mm)';

  @override
  String get page_cardGenerator_help_positions =>
      'Positions are in mm from the top-left corner of the card.';

  @override
  String get page_cardGenerator_section_range => 'Cards to print';

  @override
  String get page_cardGenerator_from => 'From number';

  @override
  String get page_cardGenerator_to => 'To number';

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
    return '$count cards, from number $start to number $end, on $_temp0. The last sheet is always complete.';
  }

  @override
  String get page_cardGenerator_saved => 'Settings saved';

  @override
  String get page_cardGenerator_quickPreview => 'Quick preview';

  @override
  String get page_cardGenerator_pdfPreview => 'PDF preview';

  @override
  String get page_cardGenerator_quickPreview_help =>
      'First page only, approximate rendering. The PDF preview shows every page as it prints.';

  @override
  String get data_event_protectCards =>
      'Protect cards against copying and reuse';

  @override
  String get data_event_protectCards_help =>
      'A secret code specific to this event is added to the cards\' QR code: a card from another edition is not recognised.';

  @override
  String get data_event_protectCards_locked =>
      'Players already exist: the protection can no longer change.';

  @override
  String get data_event_recoverSalt =>
      'Recover the protection from a printed card';

  @override
  String get data_event_recoverSalt_scan =>
      'Scan a printed card with the scanner…';

  @override
  String get data_event_recoverSalt_none => 'This card has no protection.';

  @override
  String data_event_deletePlayers_confirm(Object count) {
    return 'Delete the $count players of this event? Their badges and the draw winners will be lost. Printed cards will not be recognised until the players are generated again.';
  }

  @override
  String get page_drawList_title => 'Draws';

  @override
  String get page_drawList_menuItem => 'Draws';

  @override
  String get widget_eventSelectedGuard_pleaseSelectEvent =>
      'Please select an event';

  @override
  String get widget_eventSelectedGuard_chooseEvent => 'Choose an event';

  @override
  String get widget_mainRail_createEventFirst => 'Create an event first';

  @override
  String get widget_eventSelector_selectTitle => 'Select event';

  @override
  String get widget_playerGroupSelector_selectTitle => 'Select player group';

  @override
  String get widget_colorSelector_selectTitle => 'Select Color';

  @override
  String get widget_iconSelector_selectTitle => 'Select Icon';

  @override
  String get loading_error => 'Loading error';

  @override
  String get save_failed => 'Failed to save';

  @override
  String get save_successful => 'Saved successfully';

  @override
  String get delete_failed => 'Failed to delete';

  @override
  String get delete_successful => 'Deleted successfully';

  @override
  String message_player_scanned(Object pnumber) {
    return 'Player $pnumber has been scanned';
  }
}
