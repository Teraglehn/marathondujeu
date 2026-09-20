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
  String editor_event_sessions_count(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
      zero: 'No session',
    );
    return '$_temp0';
  }

  @override
  String editor_event_sessions_line(Object number, Object start, Object end) {
    return '$number: $start – $end';
  }

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
  String get data_playerGroup_kind_winners => 'Winners group';

  @override
  String get data_playerGroup_winners_help =>
      'Winners group of a draw: it is named after the draw and cannot be deleted.';

  @override
  String data_playerGroup_usedByDraws(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Used by $count draws: it cannot be deleted.',
      one: 'Used by one draw: it cannot be deleted.',
    );
    return '$_temp0';
  }

  @override
  String data_playerGroup_delete_confirm(Object name) {
    return 'Delete the group \"$name\"? Its players are not deleted.';
  }

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
  String page_playerList_alreadyExisting(Object count) {
    return 'Already $count existing players';
  }

  @override
  String get page_playerGroupsList_title => 'Player Groups';

  @override
  String get page_playerGroupsList_menuItem => 'Player Groups';

  @override
  String get page_playerGroupsList_help_winners =>
      'Winners groups of draws are not listed here: find them in the draw that created them, and in a draw\'s choices.';

  @override
  String get page_playerGroup_title => 'Player Group';

  @override
  String page_playerGroup_members(Object count) {
    return 'Members ($count)';
  }

  @override
  String get page_playerGroup_addByNumber => 'Add by number';

  @override
  String page_playerGroup_alreadyMember(Object number) {
    return 'Number $number already in the group';
  }

  @override
  String get page_playerGroup_help_removeMode =>
      'Removal mode: each player gets a Remove button, which takes them off the group right away.';

  @override
  String get page_sessionList_title => 'Sessions';

  @override
  String get page_sessionList_menuItem => 'Sessions';

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
  String page_cardGenerator_playerCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count players',
      one: '1 player',
      zero: 'No player',
    );
    return '$_temp0';
  }

  @override
  String get page_cardGenerator_generateExtraPlayers =>
      'Generate the extra players';

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
  String get data_event_regenerateSessions_title => 'Recreate the sessions?';

  @override
  String data_event_regenerateSessions_confirm(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count badges',
      one: '1 badge',
    );
    return 'The schedule changed: the sessions will be recreated and $_temp0 lost.';
  }

  @override
  String get data_event_regenerateSessions_revert => 'Undo the changes';

  @override
  String get data_event_regenerateSessions_recreate => 'Recreate the sessions';

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
  String get scan_hint_openPlayer => 'Scan a card to open the player\'s sheet';

  @override
  String get scan_hint_addToGroup =>
      'Scan a card to add the player to the group';

  @override
  String get scan_hint_badgeOpenSession =>
      'Scan a card to badge the open session';

  @override
  String get scan_hint_badgeThisSession => 'Scan a card to badge this session';

  @override
  String get scan_hint_removeFromGroup =>
      'Scan a card to remove the player from the group';

  @override
  String get scan_hint_removeFromSession =>
      'Scan a card to remove the player from this session';

  @override
  String scan_removedFromGroup(Object number) {
    return 'Player $number removed from the group';
  }

  @override
  String scan_notInGroup(Object number) {
    return 'Player $number is not in the group';
  }

  @override
  String scan_removedFromSession(Object number, Object session) {
    return 'Player $number removed from session $session';
  }

  @override
  String scan_notPresent(Object number, Object session) {
    return 'Player $number is not on session $session';
  }

  @override
  String scan_opened(Object number) {
    return 'Player $number: card opened';
  }

  @override
  String scan_addedToGroup(Object number) {
    return 'Player $number added to the group';
  }

  @override
  String scan_alreadyInGroup(Object number) {
    return 'Player $number already in the group';
  }

  @override
  String scan_badged(Object number, Object session) {
    return 'Player $number badged on session $session';
  }

  @override
  String scan_alreadyPresent(Object number, Object session) {
    return 'Player $number already present on session $session';
  }

  @override
  String get scan_noOpenSession => 'No open session';

  @override
  String get scan_sessionNotOpen => 'The session is not open';

  @override
  String get scan_invalidCard => 'Invalid card';

  @override
  String get scan_noEvent => 'No event selected';

  @override
  String get help_button => 'Page help';

  @override
  String get help_next => 'Next';

  @override
  String get help_finish => 'Done';

  @override
  String get help_skip => 'Skip';

  @override
  String help_counter(Object index, Object count) {
    return '$index / $count';
  }

  @override
  String get help_hint_playerCount =>
      'The total number of cards for the event. Raise it to create the missing players; players cannot be removed here.';

  @override
  String get help_hint_manualBadge =>
      'When on, the scanner and the Number field badge this session even outside its time slot.';

  @override
  String get help_hint_removeMode =>
      'When on, a scan or a number removes the player instead of adding them.';

  @override
  String get help_hint_sessionNumber =>
      'No card at hand: type the player\'s number, then Enter.';

  @override
  String get help_hint_groupNumber =>
      'Type a player\'s number, then Enter, to add them without their card.';

  @override
  String get page_playerList_legend =>
      'Tokens = badged sessions + bonus: the player\'s chances in the draw. A grey bubble has no token — the player is not in the urn.';

  @override
  String get help_eventList_1 =>
      'This page lists your events — one per edition of the Marathon. Everything else in the application works on the event chosen at the top right.';

  @override
  String get help_eventList_2 =>
      'Create an event with this button: its name, dates, session duration and interval. Sessions are generated by themselves.';

  @override
  String get help_eventList_3 => 'Find an event by its name.';

  @override
  String get help_eventList_4 =>
      'Click an event to edit it: dates, card protection, deleting players.';

  @override
  String get help_eventList_5 =>
      'Choose here the event you are working on: players, sessions, draws and cards are its own.';

  @override
  String get help_eventList_6 =>
      'Wherever you are, scanning a card opens the player\'s sheet; the result of the last scan shows here.';

  @override
  String get help_playerList_1 =>
      'Players are anonymous: each one is a card number. This page creates them and tracks their tokens.';

  @override
  String get help_playerList_2 =>
      'Enter how many cards you print, then \"Generate missing players\": the missing numbers are created.';

  @override
  String get help_playerList_3 =>
      'One card per player: their number, badged sessions, bonus, tokens. Click it to open their sheet.';

  @override
  String get help_playerList_3_empty =>
      'Players will appear here, one card each, once you have generated them.';

  @override
  String get help_playerList_4 =>
      '\"+\" and \"−\" on the Bonus line give or take sessions: one token more or less in the draw.';

  @override
  String get help_playerList_5 =>
      'Tokens = sessions + bonus: the player\'s chances in the draw. A grey bubble has no token.';

  @override
  String get help_playerList_6 => 'Scanning a card opens that player\'s sheet.';

  @override
  String get help_playerGroupList_1 =>
      'A group gathers players for the draws, and nothing else: a draw can require or exclude its members.';

  @override
  String get help_playerGroupList_2 =>
      'Create a group: a name is enough. Players are added on its page afterwards.';

  @override
  String get help_playerGroupList_3 =>
      'Click a group to open its page; the pencil renames it, the bin deletes it (its players remain).';

  @override
  String get help_playerGroupList_3_empty => 'Your groups will appear here.';

  @override
  String get help_playerGroupList_4 =>
      'Winner groups are not listed: they live in the draw that created them.';

  @override
  String get help_playerGroupList_5 =>
      'Here, scanning a card opens the player\'s sheet. On a group\'s page, it adds them to the group.';

  @override
  String get help_playerGroup_1 =>
      'A group\'s page: its members, and how to add or remove them.';

  @override
  String get help_playerGroup_2 =>
      'Scan a player\'s card: they join the group. Already a member, nothing changes.';

  @override
  String get help_playerGroup_3 =>
      'No card: type their number, then Enter or \"Add\".';

  @override
  String get help_playerGroup_4 =>
      'Remove mode: a scan or a number removes the player, and each bubble gets a \"Remove\" button.';

  @override
  String get help_playerGroup_5 => 'The group\'s members, by number.';

  @override
  String get help_playerGroup_6 =>
      'The pencil renames the group, or deletes it.';

  @override
  String get help_sessionList_1 =>
      'A session is a badging time slot. Players who are there scan their card: each badged session is worth one token in the draw.';

  @override
  String get help_sessionList_2 =>
      'The application\'s time: it decides which session is open.';

  @override
  String get help_sessionList_3_open =>
      'The open session is coloured: this is where the scanner badges right now. Click a card to open its session.';

  @override
  String get help_sessionList_3_closed =>
      'No session is open at this time: the scanner does not badge. Click a card to open a session and badge by hand.';

  @override
  String get help_sessionList_3_empty =>
      'Sessions are generated from the event: its dates, session duration and interval.';

  @override
  String get help_sessionList_4 =>
      'From this page, scanning a card badges the open session, without opening it.';

  @override
  String get help_sessionList_5 =>
      'The colours: open, past, upcoming. \"n present\" counts the badged players.';

  @override
  String get help_session_1 =>
      'A session\'s page: who is here, who is missing, and the ways to badge.';

  @override
  String get help_session_2 =>
      'The time slot, its state (open, past) and the time.';

  @override
  String get help_session_3 =>
      'Scan a card: the player moves to Present. Outside the time slot the scan is refused — unless manual badging is on.';

  @override
  String get help_session_4 =>
      'Manual badging: to badge outside the time slot — a latecomer, a past session.';

  @override
  String get help_session_5 =>
      'No card: the player\'s number, then Enter or \"Add\".';

  @override
  String get help_session_6 =>
      'Remove mode: a scan, a number or a bubble\'s \"Remove\" button takes the player out of the session.';

  @override
  String get help_session_7 => 'Present: the players badged on this session.';

  @override
  String get help_session_8 =>
      'Absent: those who badged another session, but not this one. A player never badged does not appear.';

  @override
  String get help_session_9 => 'Back to the session list.';

  @override
  String get help_drawList_1 =>
      'A draw picks winners at random among the players: the more tokens a player has, the better their chances.';

  @override
  String get help_drawList_2 =>
      'Create a draw: number of winners, required or excluded sessions and groups, then \"Draw\".';

  @override
  String get help_drawList_3 => 'Click a draw to view or edit it.';

  @override
  String get help_drawList_3_empty =>
      'Your draws will appear here, with their winners.';

  @override
  String get help_drawList_3_drawn =>
      'A padlock: the draw is done and can no longer be edited. Its winners are shown; click one to open their sheet.';

  @override
  String get help_drawList_4 =>
      'Copy takes a draw\'s settings into a new one — to draw again with the same rules.';

  @override
  String get help_drawList_5 => 'Scanning a card opens the player\'s sheet.';

  @override
  String get help_cardGenerator_1 =>
      'This page prepares the cards to print: a background image, each player\'s code, their number.';

  @override
  String get help_cardGenerator_2 =>
      'Choose the background image by clicking the frame. The card height follows its proportions.';

  @override
  String get help_cardGenerator_3 =>
      'The sheet: how many cards per row and per page, their width, the margins.';

  @override
  String get help_cardGenerator_4 =>
      'The card\'s code: its size and position, in millimetres from the top left corner.';

  @override
  String get help_cardGenerator_5 =>
      'The number: the same, plus the font and colour.';

  @override
  String get help_cardGenerator_6 =>
      'From number… to number…: the cards to print. Beyond the existing players, a button creates them.';

  @override
  String get help_cardGenerator_7 =>
      'The quick preview follows your settings; the PDF preview is what gets printed, with its print button.';

  @override
  String get help_cardGenerator_8 =>
      'Save: the settings are kept with the event.';

  @override
  String get help_guide_menuItem => 'Guide';

  @override
  String get help_guide_title => 'Guide — an edition from start to finish';

  @override
  String get help_guide_intro =>
      'An edition of the Marathon runs in six steps, in the order of the pages in the left rail. Each page has its own \"i\" at the top right for the details.';

  @override
  String get help_guide_where_title => 'Where to find help';

  @override
  String get help_guide_where_hint =>
      'A small \"i\" next to a field or a switch: hover it, one sentence explains it.';

  @override
  String get help_guide_where_legend =>
      'A text in the screen, under a list or a form: the legend of what you see.';

  @override
  String get help_guide_where_tour =>
      'The \"i\" at the top right of each page: a step-by-step tour of the screen, area by area.';

  @override
  String get help_guide_step_1_title => 'Create the event';

  @override
  String get help_guide_step_1_text =>
      'Name, start, end, session duration and interval: the preview shows the sessions that will be created, they are generated by themselves. Give it a backup file: the application rewrites it after every change, and \"Open a backup file\" brings the whole event back on another computer. Then choose this event at the top right of the other pages.';

  @override
  String get help_guide_step_2_title => 'Generate the players';

  @override
  String get help_guide_step_2_text =>
      'Enter how many cards you print: one player per number, anonymous. Each player collects tokens — their chances in the draw.';

  @override
  String get help_guide_step_3_title => 'Print the cards';

  @override
  String get help_guide_step_3_text =>
      'In the Card generator: a background image, the code and the number placed on it, then printing. Each player gets their card.';

  @override
  String get help_guide_step_4_title => 'Badge at every session';

  @override
  String get help_guide_step_4_text =>
      'During the open session (coloured), the players who are there scan their card: one token per badged session.';

  @override
  String get help_guide_step_5_title => 'Gather players (optional)';

  @override
  String get help_guide_step_5_text =>
      'A group is for the draws, and nothing else: a draw can require or exclude its members.';

  @override
  String get help_guide_step_6_title => 'Draw the winners';

  @override
  String get help_guide_step_6_text =>
      'Number of winners, required or excluded sessions or groups, then \"Draw\": the more tokens a player has, the better their chances. The winners are shown, the draw locks.';

  @override
  String help_guide_open(Object page) {
    return 'Open the $page page';
  }

  @override
  String get help_guide_sample_event => 'Board Game Marathon 2026';

  @override
  String get help_guide_sample_group => 'The regulars';

  @override
  String get backup_title => 'Backup file';

  @override
  String get backup_help =>
      'The application rewrites this file by itself after every change: players, badges, groups, draws, card image. Keep it in a synced folder or on a USB stick: it brings the event back on another computer.';

  @override
  String get backup_none => 'No file: this event is not backed up.';

  @override
  String get backup_choose => 'Choose…';

  @override
  String get backup_remove => 'Remove';

  @override
  String backup_lastWritten(Object time) {
    return 'Last backup at $time';
  }

  @override
  String get backup_notYetWritten =>
      'Not written yet — at the next change, or when saving.';

  @override
  String backup_suggestedName(Object name) {
    return '$name.marathon.json';
  }

  @override
  String backup_writeError(Object name) {
    return 'Backup failed for \"$name\": check the file\'s folder.';
  }

  @override
  String backup_pathLost(Object name) {
    return 'The backup folder of \"$name\" no longer exists: choose a new one in the event.';
  }

  @override
  String get backup_open => 'Open a backup file';

  @override
  String backup_opened(Object name) {
    return 'Event \"$name\" added';
  }

  @override
  String backup_replaced(Object name) {
    return 'Event \"$name\" replaced';
  }

  @override
  String get backup_unreadable => 'This file is not a readable backup file.';

  @override
  String get backup_exists_title => 'This event is already here';

  @override
  String backup_exists_text(Object name) {
    return '\"$name\" is already in the list. Replace it with the file\'s content? What was done since in the application will be lost.';
  }

  @override
  String get backup_replace => 'Replace';

  @override
  String get help_eventList_7 =>
      'Open a backup file to bring an event back — after a dead computer, or from another one. Each event chooses its file in its editor.';
}
