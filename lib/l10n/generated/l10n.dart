import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Marathon du Jeu'**
  String get app_title;

  /// No description provided for @utils_searchField_label.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get utils_searchField_label;

  /// No description provided for @utils_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get utils_button_cancel;

  /// No description provided for @utils_button_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get utils_button_save;

  /// No description provided for @utils_button_saveAll.
  ///
  /// In en, this message translates to:
  /// **'Save All'**
  String get utils_button_saveAll;

  /// No description provided for @utils_button_saveNItems.
  ///
  /// In en, this message translates to:
  /// **'Save {count} {objName}'**
  String utils_button_saveNItems(Object count, Object objName);

  /// No description provided for @utils_button_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get utils_button_delete;

  /// No description provided for @utils_button_deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get utils_button_deleteAll;

  /// No description provided for @utils_button_deleteNItems.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} {objName}'**
  String utils_button_deleteNItems(Object count, Object objName);

  /// No description provided for @utils_button_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get utils_button_add;

  /// No description provided for @utils_button_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get utils_button_edit;

  /// No description provided for @utils_button_select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get utils_button_select;

  /// No description provided for @utils_button_select_all.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get utils_button_select_all;

  /// No description provided for @utils_button_deselect_all.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get utils_button_deselect_all;

  /// No description provided for @utils_button_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get utils_button_close;

  /// No description provided for @editor_title_player.
  ///
  /// In en, this message translates to:
  /// **'Edit a player'**
  String get editor_title_player;

  /// No description provided for @editor_title_event_create.
  ///
  /// In en, this message translates to:
  /// **'Create an event'**
  String get editor_title_event_create;

  /// No description provided for @editor_title_event_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit an event'**
  String get editor_title_event_edit;

  /// No description provided for @editor_title_playerGroup_create.
  ///
  /// In en, this message translates to:
  /// **'Create a player group'**
  String get editor_title_playerGroup_create;

  /// No description provided for @editor_title_playerGroup_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit a player group'**
  String get editor_title_playerGroup_edit;

  /// No description provided for @editor_title_draw_create.
  ///
  /// In en, this message translates to:
  /// **'Create a draw'**
  String get editor_title_draw_create;

  /// No description provided for @editor_title_draw_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit a draw'**
  String get editor_title_draw_edit;

  /// No description provided for @editor_title_draw_view.
  ///
  /// In en, this message translates to:
  /// **'View a draw'**
  String get editor_title_draw_view;

  /// No description provided for @editor_dirty_title.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get editor_dirty_title;

  /// No description provided for @editor_dirty_text.
  ///
  /// In en, this message translates to:
  /// **'Do you want to leave? What was changed will be lost.'**
  String get editor_dirty_text;

  /// No description provided for @editor_dirty_stay.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get editor_dirty_stay;

  /// No description provided for @editor_dirty_leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get editor_dirty_leave;

  /// No description provided for @editor_event_sessions_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No session} =1{1 session} other{{count} sessions}}'**
  String editor_event_sessions_count(num count);

  /// No description provided for @editor_event_sessions_line.
  ///
  /// In en, this message translates to:
  /// **'{number}: {start} – {end}'**
  String editor_event_sessions_line(Object number, Object start, Object end);

  /// No description provided for @utils_button_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get utils_button_reset;

  /// No description provided for @utils_icon_filled.
  ///
  /// In en, this message translates to:
  /// **'Filled'**
  String get utils_icon_filled;

  /// No description provided for @utils_icon_outlined.
  ///
  /// In en, this message translates to:
  /// **'Outlined'**
  String get utils_icon_outlined;

  /// No description provided for @utils_icon_rounded.
  ///
  /// In en, this message translates to:
  /// **'Rounded'**
  String get utils_icon_rounded;

  /// No description provided for @utils_icon_sharp.
  ///
  /// In en, this message translates to:
  /// **'Sharp'**
  String get utils_icon_sharp;

  /// No description provided for @data_player_objName.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Player} other {Players}}'**
  String data_player_objName(num count);

  /// No description provided for @data_player_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get data_player_name;

  /// No description provided for @data_player_qrcode.
  ///
  /// In en, this message translates to:
  /// **'QRCode'**
  String get data_player_qrcode;

  /// No description provided for @data_player_number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get data_player_number;

  /// No description provided for @data_player_bonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get data_player_bonus;

  /// No description provided for @data_player_tokens.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Token} other {Tokens}}'**
  String data_player_tokens(num count);

  /// No description provided for @data_player_error_name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get data_player_error_name_required;

  /// No description provided for @data_player_error_qrCode_required.
  ///
  /// In en, this message translates to:
  /// **'QrCode is required'**
  String get data_player_error_qrCode_required;

  /// No description provided for @data_playerGroup_objName.
  ///
  /// In en, this message translates to:
  /// **'Player {count, plural, one {Group} other {Groups}}'**
  String data_playerGroup_objName(num count);

  /// No description provided for @data_playerGroup_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get data_playerGroup_name;

  /// No description provided for @data_playerGroup_error_name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get data_playerGroup_error_name_required;

  /// No description provided for @data_playerGroup_kind_winners.
  ///
  /// In en, this message translates to:
  /// **'Winners group'**
  String get data_playerGroup_kind_winners;

  /// No description provided for @data_playerGroup_winners_help.
  ///
  /// In en, this message translates to:
  /// **'Winners group of a draw: it is named after the draw and cannot be deleted.'**
  String get data_playerGroup_winners_help;

  /// No description provided for @data_playerGroup_usedByDraws.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Used by one draw: it cannot be deleted.} other {Used by {count} draws: it cannot be deleted.}}'**
  String data_playerGroup_usedByDraws(num count);

  /// No description provided for @data_playerGroup_delete_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete the group \"{name}\"? Its players are not deleted.'**
  String data_playerGroup_delete_confirm(Object name);

  /// No description provided for @data_draw_objName.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Draw} other {Draws}}'**
  String data_draw_objName(num count);

  /// No description provided for @data_draw_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get data_draw_name;

  /// No description provided for @data_draw_minSessionNumber.
  ///
  /// In en, this message translates to:
  /// **'Min number of session'**
  String get data_draw_minSessionNumber;

  /// No description provided for @data_draw_maxSessionNumber.
  ///
  /// In en, this message translates to:
  /// **'Max number of session'**
  String get data_draw_maxSessionNumber;

  /// No description provided for @data_draw_excludedSessions.
  ///
  /// In en, this message translates to:
  /// **'Excluded sessions'**
  String get data_draw_excludedSessions;

  /// No description provided for @data_draw_requiredSessions.
  ///
  /// In en, this message translates to:
  /// **'Required sessions'**
  String get data_draw_requiredSessions;

  /// No description provided for @data_draw_excludedPlayers.
  ///
  /// In en, this message translates to:
  /// **'Excluded players'**
  String get data_draw_excludedPlayers;

  /// No description provided for @data_draw_requiredPlayers.
  ///
  /// In en, this message translates to:
  /// **'Required players'**
  String get data_draw_requiredPlayers;

  /// No description provided for @data_draw_winnerCount.
  ///
  /// In en, this message translates to:
  /// **'Number of winners to draw'**
  String get data_draw_winnerCount;

  /// No description provided for @data_draw_playerCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Player} other {Players}} selected for drawing lots'**
  String data_draw_playerCount(num count);

  /// No description provided for @data_draw_error_name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get data_draw_error_name_required;

  /// No description provided for @data_draw_tokenCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No token in the urn} one {1 token in the urn} other {{count} tokens in the urn}}'**
  String data_draw_tokenCount(num count);

  /// No description provided for @data_draw_eligibility_help.
  ///
  /// In en, this message translates to:
  /// **'Only players with at least one token count. Each token is one chance in the draw.'**
  String get data_draw_eligibility_help;

  /// No description provided for @data_draw_excludedPlayers_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No individually excluded player} one {1 individually excluded player} other {{count} individually excluded players}}'**
  String data_draw_excludedPlayers_count(num count);

  /// No description provided for @data_draw_drawnAt.
  ///
  /// In en, this message translates to:
  /// **'Drawn on {date}'**
  String data_draw_drawnAt(Object date);

  /// No description provided for @data_draw_drawn.
  ///
  /// In en, this message translates to:
  /// **'Drawn'**
  String get data_draw_drawn;

  /// No description provided for @data_draw_drawn_help.
  ///
  /// In en, this message translates to:
  /// **'This draw has been made: it can no longer be edited or relaunched. To start again, copy it.'**
  String get data_draw_drawn_help;

  /// No description provided for @data_draw_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get data_draw_copy;

  /// No description provided for @data_draw_copy_help.
  ///
  /// In en, this message translates to:
  /// **'The copy keeps the same settings and excludes this draw\'s winners.'**
  String get data_draw_copy_help;

  /// No description provided for @data_draw_launch.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get data_draw_launch;

  /// No description provided for @data_draw_launch_confirm.
  ///
  /// In en, this message translates to:
  /// **'Draw {winners} winners among {players} players? A draw is launched only once.'**
  String data_draw_launch_confirm(Object winners, Object players);

  /// No description provided for @data_event_objName.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Event} other {Events}}'**
  String data_event_objName(num count);

  /// No description provided for @data_event_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get data_event_name;

  /// No description provided for @data_event_datetime_start.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get data_event_datetime_start;

  /// No description provided for @data_event_datetime_end.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get data_event_datetime_end;

  /// No description provided for @data_event_session_duration_minute.
  ///
  /// In en, this message translates to:
  /// **'Session duration (min)'**
  String get data_event_session_duration_minute;

  /// No description provided for @data_event_session_interval_minute.
  ///
  /// In en, this message translates to:
  /// **'Session interval (min)'**
  String get data_event_session_interval_minute;

  /// No description provided for @data_event_error_name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get data_event_error_name_required;

  /// No description provided for @data_event_error_datetime_start_required.
  ///
  /// In en, this message translates to:
  /// **'Start time is required'**
  String get data_event_error_datetime_start_required;

  /// No description provided for @data_event_error_datetime_end_required.
  ///
  /// In en, this message translates to:
  /// **'End time is required'**
  String get data_event_error_datetime_end_required;

  /// No description provided for @data_event_error_session_duration_minute_required.
  ///
  /// In en, this message translates to:
  /// **'Session duration is required'**
  String get data_event_error_session_duration_minute_required;

  /// No description provided for @data_event_error_session_interval_minute_required.
  ///
  /// In en, this message translates to:
  /// **'Session interval is required'**
  String get data_event_error_session_interval_minute_required;

  /// No description provided for @data_session_objName.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {Session} other {Sessions}}'**
  String data_session_objName(num count);

  /// No description provided for @page_playerList_title.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get page_playerList_title;

  /// No description provided for @page_playerList_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get page_playerList_menuItem;

  /// No description provided for @page_playerList_playerCount.
  ///
  /// In en, this message translates to:
  /// **'Players count'**
  String get page_playerList_playerCount;

  /// No description provided for @page_playerList_generateMissingPlayers.
  ///
  /// In en, this message translates to:
  /// **'Generate missing players'**
  String get page_playerList_generateMissingPlayers;

  /// No description provided for @page_playerList_deletePlayers.
  ///
  /// In en, this message translates to:
  /// **'Delete players'**
  String get page_playerList_deletePlayers;

  /// No description provided for @page_playerList_alreadyExisting.
  ///
  /// In en, this message translates to:
  /// **'Already {count} existing players'**
  String page_playerList_alreadyExisting(Object count);

  /// No description provided for @page_playerGroupsList_title.
  ///
  /// In en, this message translates to:
  /// **'Player Groups'**
  String get page_playerGroupsList_title;

  /// No description provided for @page_playerGroupsList_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Player Groups'**
  String get page_playerGroupsList_menuItem;

  /// No description provided for @page_playerGroupsList_help_winners.
  ///
  /// In en, this message translates to:
  /// **'Winners groups of draws are not listed here: find them in the draw that created them, and in a draw\'s choices.'**
  String get page_playerGroupsList_help_winners;

  /// No description provided for @page_playerGroup_title.
  ///
  /// In en, this message translates to:
  /// **'Player Group'**
  String get page_playerGroup_title;

  /// No description provided for @page_playerGroup_members.
  ///
  /// In en, this message translates to:
  /// **'Members ({count})'**
  String page_playerGroup_members(Object count);

  /// No description provided for @page_playerGroup_addByNumber.
  ///
  /// In en, this message translates to:
  /// **'Add by number'**
  String get page_playerGroup_addByNumber;

  /// No description provided for @page_playerGroup_alreadyMember.
  ///
  /// In en, this message translates to:
  /// **'Number {number} already in the group'**
  String page_playerGroup_alreadyMember(Object number);

  /// No description provided for @page_playerGroup_help_removeMode.
  ///
  /// In en, this message translates to:
  /// **'Removal mode: each player gets a Remove button, which takes them off the group right away.'**
  String get page_playerGroup_help_removeMode;

  /// No description provided for @page_sessionList_title.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get page_sessionList_title;

  /// No description provided for @page_sessionList_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get page_sessionList_menuItem;

  /// No description provided for @page_session_title.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get page_session_title;

  /// No description provided for @page_session_manualAdd.
  ///
  /// In en, this message translates to:
  /// **'Manual badging'**
  String get page_session_manualAdd;

  /// No description provided for @page_session_header.
  ///
  /// In en, this message translates to:
  /// **'Session {number} — {start} to {end}'**
  String page_session_header(Object end, Object number, Object start);

  /// No description provided for @page_session_state_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get page_session_state_open;

  /// No description provided for @page_session_state_past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get page_session_state_past;

  /// No description provided for @page_session_zone_present.
  ///
  /// In en, this message translates to:
  /// **'Present ({count})'**
  String page_session_zone_present(Object count);

  /// No description provided for @page_session_zone_absent.
  ///
  /// In en, this message translates to:
  /// **'Absent ({count})'**
  String page_session_zone_absent(Object count);

  /// No description provided for @page_session_removeMode.
  ///
  /// In en, this message translates to:
  /// **'Removal mode'**
  String get page_session_removeMode;

  /// No description provided for @page_session_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get page_session_remove;

  /// No description provided for @page_session_number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get page_session_number;

  /// No description provided for @page_session_number_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown number {number}'**
  String page_session_number_unknown(Object number);

  /// No description provided for @page_session_help_absent.
  ///
  /// In en, this message translates to:
  /// **'Absent: badged another session, not this one. Players who have not badged any session yet are not shown.'**
  String get page_session_help_absent;

  /// No description provided for @page_session_help_removeMode.
  ///
  /// In en, this message translates to:
  /// **'Removal mode: each present player gets a Remove button, which takes them off the session right away.'**
  String get page_session_help_removeMode;

  /// No description provided for @page_sessionList_legend_open.
  ///
  /// In en, this message translates to:
  /// **'Open: badging is possible now'**
  String get page_sessionList_legend_open;

  /// No description provided for @page_sessionList_legend_past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get page_sessionList_legend_past;

  /// No description provided for @page_sessionList_legend_upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get page_sessionList_legend_upcoming;

  /// No description provided for @page_sessionList_present.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {present} other {present}}'**
  String page_sessionList_present(num count);

  /// No description provided for @form_player_bonus_help.
  ///
  /// In en, this message translates to:
  /// **'Each bonus point adds one token for the draws'**
  String get form_player_bonus_help;

  /// No description provided for @form_player_legend_present.
  ///
  /// In en, this message translates to:
  /// **'Present: the player badged this session'**
  String get form_player_legend_present;

  /// No description provided for @form_player_legend_absent.
  ///
  /// In en, this message translates to:
  /// **'Absent: the player did not badge this session'**
  String get form_player_legend_absent;

  /// No description provided for @form_player_legend_manual.
  ///
  /// In en, this message translates to:
  /// **'Manual badging: click a session to mark the player present or absent, then Save'**
  String get form_player_legend_manual;

  /// No description provided for @page_eventList_title.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get page_eventList_title;

  /// No description provided for @page_eventList_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get page_eventList_menuItem;

  /// No description provided for @page_eventList_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Create an event'**
  String get page_eventList_empty_title;

  /// No description provided for @page_eventList_empty_text.
  ///
  /// In en, this message translates to:
  /// **'Everything starts with an event: its dates, its sessions, its players.'**
  String get page_eventList_empty_text;

  /// No description provided for @page_cardGenerator_title.
  ///
  /// In en, this message translates to:
  /// **'Card Generator'**
  String get page_cardGenerator_title;

  /// No description provided for @page_cardGenerator_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Card Generator'**
  String get page_cardGenerator_menuItem;

  /// No description provided for @page_cardGenerator_noImage.
  ///
  /// In en, this message translates to:
  /// **'Choose a background image to preview the cards.'**
  String get page_cardGenerator_noImage;

  /// No description provided for @page_cardGenerator_image.
  ///
  /// In en, this message translates to:
  /// **'Background image'**
  String get page_cardGenerator_image;

  /// No description provided for @page_cardGenerator_section_sheet.
  ///
  /// In en, this message translates to:
  /// **'Sheet'**
  String get page_cardGenerator_section_sheet;

  /// No description provided for @page_cardGenerator_cardsPerRow.
  ///
  /// In en, this message translates to:
  /// **'Cards per row'**
  String get page_cardGenerator_cardsPerRow;

  /// No description provided for @page_cardGenerator_rowsPerPage.
  ///
  /// In en, this message translates to:
  /// **'Rows per page'**
  String get page_cardGenerator_rowsPerPage;

  /// No description provided for @page_cardGenerator_portrait.
  ///
  /// In en, this message translates to:
  /// **'Portrait'**
  String get page_cardGenerator_portrait;

  /// No description provided for @page_cardGenerator_landscape.
  ///
  /// In en, this message translates to:
  /// **'Landscape'**
  String get page_cardGenerator_landscape;

  /// No description provided for @page_cardGenerator_cardWidth.
  ///
  /// In en, this message translates to:
  /// **'Card width (mm)'**
  String get page_cardGenerator_cardWidth;

  /// No description provided for @page_cardGenerator_cardHeight.
  ///
  /// In en, this message translates to:
  /// **'Height: {mm} mm, from the image'**
  String page_cardGenerator_cardHeight(Object mm);

  /// No description provided for @page_cardGenerator_pageMargin.
  ///
  /// In en, this message translates to:
  /// **'Page margin (mm)'**
  String get page_cardGenerator_pageMargin;

  /// No description provided for @page_cardGenerator_gapX.
  ///
  /// In en, this message translates to:
  /// **'Gap between cards (mm)'**
  String get page_cardGenerator_gapX;

  /// No description provided for @page_cardGenerator_gapY.
  ///
  /// In en, this message translates to:
  /// **'Gap between rows (mm)'**
  String get page_cardGenerator_gapY;

  /// No description provided for @page_cardGenerator_pageBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Page background colour'**
  String get page_cardGenerator_pageBackgroundColor;

  /// No description provided for @page_cardGenerator_section_qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR code'**
  String get page_cardGenerator_section_qrCode;

  /// No description provided for @page_cardGenerator_section_number.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get page_cardGenerator_section_number;

  /// No description provided for @page_cardGenerator_size.
  ///
  /// In en, this message translates to:
  /// **'Size (mm)'**
  String get page_cardGenerator_size;

  /// No description provided for @page_cardGenerator_posX.
  ///
  /// In en, this message translates to:
  /// **'X position (mm)'**
  String get page_cardGenerator_posX;

  /// No description provided for @page_cardGenerator_posY.
  ///
  /// In en, this message translates to:
  /// **'Y position (mm)'**
  String get page_cardGenerator_posY;

  /// No description provided for @page_cardGenerator_fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size (pt)'**
  String get page_cardGenerator_fontSize;

  /// No description provided for @page_cardGenerator_color.
  ///
  /// In en, this message translates to:
  /// **'Colour'**
  String get page_cardGenerator_color;

  /// No description provided for @page_cardGenerator_background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get page_cardGenerator_background;

  /// No description provided for @page_cardGenerator_backgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background colour'**
  String get page_cardGenerator_backgroundColor;

  /// No description provided for @page_cardGenerator_padding.
  ///
  /// In en, this message translates to:
  /// **'Background padding (mm)'**
  String get page_cardGenerator_padding;

  /// No description provided for @page_cardGenerator_help_positions.
  ///
  /// In en, this message translates to:
  /// **'Positions are in mm from the top-left corner of the card.'**
  String get page_cardGenerator_help_positions;

  /// No description provided for @page_cardGenerator_section_range.
  ///
  /// In en, this message translates to:
  /// **'Cards to print'**
  String get page_cardGenerator_section_range;

  /// No description provided for @page_cardGenerator_from.
  ///
  /// In en, this message translates to:
  /// **'From number'**
  String get page_cardGenerator_from;

  /// No description provided for @page_cardGenerator_to.
  ///
  /// In en, this message translates to:
  /// **'To number'**
  String get page_cardGenerator_to;

  /// No description provided for @page_cardGenerator_summary.
  ///
  /// In en, this message translates to:
  /// **'{count} cards, from number {start} to number {end}, on {pages, plural, one {1 page} other {{pages} pages}}. The last sheet is always complete.'**
  String page_cardGenerator_summary(
    Object count,
    Object start,
    Object end,
    num pages,
  );

  /// No description provided for @page_cardGenerator_playerCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No player} one {1 player} other {{count} players}}'**
  String page_cardGenerator_playerCount(num count);

  /// No description provided for @page_cardGenerator_generateExtraPlayers.
  ///
  /// In en, this message translates to:
  /// **'Generate the extra players'**
  String get page_cardGenerator_generateExtraPlayers;

  /// No description provided for @page_cardGenerator_saved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get page_cardGenerator_saved;

  /// No description provided for @page_cardGenerator_quickPreview.
  ///
  /// In en, this message translates to:
  /// **'Quick preview'**
  String get page_cardGenerator_quickPreview;

  /// No description provided for @page_cardGenerator_pdfPreview.
  ///
  /// In en, this message translates to:
  /// **'PDF preview'**
  String get page_cardGenerator_pdfPreview;

  /// No description provided for @page_cardGenerator_quickPreview_help.
  ///
  /// In en, this message translates to:
  /// **'First page only, approximate rendering. The PDF preview shows every page as it prints.'**
  String get page_cardGenerator_quickPreview_help;

  /// No description provided for @data_event_protectCards.
  ///
  /// In en, this message translates to:
  /// **'Protect cards against copying and reuse'**
  String get data_event_protectCards;

  /// No description provided for @data_event_protectCards_help.
  ///
  /// In en, this message translates to:
  /// **'A secret code specific to this event is added to the cards\' QR code: a card from another edition is not recognised.'**
  String get data_event_protectCards_help;

  /// No description provided for @data_event_protectCards_locked.
  ///
  /// In en, this message translates to:
  /// **'Players already exist: the protection can no longer change.'**
  String get data_event_protectCards_locked;

  /// No description provided for @data_event_recoverSalt.
  ///
  /// In en, this message translates to:
  /// **'Recover the protection from a printed card'**
  String get data_event_recoverSalt;

  /// No description provided for @data_event_recoverSalt_scan.
  ///
  /// In en, this message translates to:
  /// **'Scan a printed card with the scanner…'**
  String get data_event_recoverSalt_scan;

  /// No description provided for @data_event_recoverSalt_none.
  ///
  /// In en, this message translates to:
  /// **'This card has no protection.'**
  String get data_event_recoverSalt_none;

  /// No description provided for @data_event_deletePlayers_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete the {count} players of this event? Their badges and the draw winners will be lost. Printed cards will not be recognised until the players are generated again.'**
  String data_event_deletePlayers_confirm(Object count);

  /// No description provided for @data_event_regenerateSessions_title.
  ///
  /// In en, this message translates to:
  /// **'Recreate the sessions?'**
  String get data_event_regenerateSessions_title;

  /// No description provided for @data_event_regenerateSessions_confirm.
  ///
  /// In en, this message translates to:
  /// **'The schedule changed: the sessions will be recreated and {count, plural, one {1 badge} other {{count} badges}} lost.'**
  String data_event_regenerateSessions_confirm(num count);

  /// No description provided for @data_event_regenerateSessions_revert.
  ///
  /// In en, this message translates to:
  /// **'Undo the changes'**
  String get data_event_regenerateSessions_revert;

  /// No description provided for @data_event_regenerateSessions_recreate.
  ///
  /// In en, this message translates to:
  /// **'Recreate the sessions'**
  String get data_event_regenerateSessions_recreate;

  /// No description provided for @page_drawList_title.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get page_drawList_title;

  /// No description provided for @page_drawList_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get page_drawList_menuItem;

  /// No description provided for @widget_eventSelectedGuard_pleaseSelectEvent.
  ///
  /// In en, this message translates to:
  /// **'Please select an event'**
  String get widget_eventSelectedGuard_pleaseSelectEvent;

  /// No description provided for @widget_eventSelectedGuard_chooseEvent.
  ///
  /// In en, this message translates to:
  /// **'Choose an event'**
  String get widget_eventSelectedGuard_chooseEvent;

  /// No description provided for @widget_mainRail_createEventFirst.
  ///
  /// In en, this message translates to:
  /// **'Create an event first'**
  String get widget_mainRail_createEventFirst;

  /// No description provided for @widget_eventSelector_selectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select event'**
  String get widget_eventSelector_selectTitle;

  /// No description provided for @widget_playerGroupSelector_selectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select player group'**
  String get widget_playerGroupSelector_selectTitle;

  /// No description provided for @widget_colorSelector_selectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get widget_colorSelector_selectTitle;

  /// No description provided for @widget_iconSelector_selectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Icon'**
  String get widget_iconSelector_selectTitle;

  /// No description provided for @loading_error.
  ///
  /// In en, this message translates to:
  /// **'Loading error'**
  String get loading_error;

  /// No description provided for @save_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save'**
  String get save_failed;

  /// No description provided for @save_successful.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get save_successful;

  /// No description provided for @delete_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete'**
  String get delete_failed;

  /// No description provided for @delete_successful.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully'**
  String get delete_successful;

  /// No description provided for @scan_hint_openPlayer.
  ///
  /// In en, this message translates to:
  /// **'Scan a card to open the player\'s sheet'**
  String get scan_hint_openPlayer;

  /// No description provided for @scan_hint_addToGroup.
  ///
  /// In en, this message translates to:
  /// **'Scan a card to add the player to the group'**
  String get scan_hint_addToGroup;

  /// No description provided for @scan_hint_badgeOpenSession.
  ///
  /// In en, this message translates to:
  /// **'Scan a card to badge the open session'**
  String get scan_hint_badgeOpenSession;

  /// No description provided for @scan_hint_badgeThisSession.
  ///
  /// In en, this message translates to:
  /// **'Scan a card to badge this session'**
  String get scan_hint_badgeThisSession;

  /// No description provided for @scan_hint_removeFromGroup.
  ///
  /// In en, this message translates to:
  /// **'Scan a card to remove the player from the group'**
  String get scan_hint_removeFromGroup;

  /// No description provided for @scan_hint_removeFromSession.
  ///
  /// In en, this message translates to:
  /// **'Scan a card to remove the player from this session'**
  String get scan_hint_removeFromSession;

  /// No description provided for @scan_removedFromGroup.
  ///
  /// In en, this message translates to:
  /// **'Player {number} removed from the group'**
  String scan_removedFromGroup(Object number);

  /// No description provided for @scan_notInGroup.
  ///
  /// In en, this message translates to:
  /// **'Player {number} is not in the group'**
  String scan_notInGroup(Object number);

  /// No description provided for @scan_removedFromSession.
  ///
  /// In en, this message translates to:
  /// **'Player {number} removed from session {session}'**
  String scan_removedFromSession(Object number, Object session);

  /// No description provided for @scan_notPresent.
  ///
  /// In en, this message translates to:
  /// **'Player {number} is not on session {session}'**
  String scan_notPresent(Object number, Object session);

  /// No description provided for @scan_opened.
  ///
  /// In en, this message translates to:
  /// **'Player {number}: card opened'**
  String scan_opened(Object number);

  /// No description provided for @scan_addedToGroup.
  ///
  /// In en, this message translates to:
  /// **'Player {number} added to the group'**
  String scan_addedToGroup(Object number);

  /// No description provided for @scan_alreadyInGroup.
  ///
  /// In en, this message translates to:
  /// **'Player {number} already in the group'**
  String scan_alreadyInGroup(Object number);

  /// No description provided for @scan_badged.
  ///
  /// In en, this message translates to:
  /// **'Player {number} badged on session {session}'**
  String scan_badged(Object number, Object session);

  /// No description provided for @scan_alreadyPresent.
  ///
  /// In en, this message translates to:
  /// **'Player {number} already present on session {session}'**
  String scan_alreadyPresent(Object number, Object session);

  /// No description provided for @scan_noOpenSession.
  ///
  /// In en, this message translates to:
  /// **'No open session'**
  String get scan_noOpenSession;

  /// No description provided for @scan_sessionNotOpen.
  ///
  /// In en, this message translates to:
  /// **'The session is not open'**
  String get scan_sessionNotOpen;

  /// No description provided for @scan_invalidCard.
  ///
  /// In en, this message translates to:
  /// **'Invalid card'**
  String get scan_invalidCard;

  /// No description provided for @scan_noEvent.
  ///
  /// In en, this message translates to:
  /// **'No event selected'**
  String get scan_noEvent;

  /// No description provided for @help_button.
  ///
  /// In en, this message translates to:
  /// **'Page help'**
  String get help_button;

  /// No description provided for @help_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get help_next;

  /// No description provided for @help_finish.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get help_finish;

  /// No description provided for @help_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get help_skip;

  /// No description provided for @help_counter.
  ///
  /// In en, this message translates to:
  /// **'{index} / {count}'**
  String help_counter(Object index, Object count);

  /// No description provided for @help_hint_playerCount.
  ///
  /// In en, this message translates to:
  /// **'The total number of cards for the event. Raise it to create the missing players; players cannot be removed here.'**
  String get help_hint_playerCount;

  /// No description provided for @help_hint_manualBadge.
  ///
  /// In en, this message translates to:
  /// **'When on, the scanner and the Number field badge this session even outside its time slot.'**
  String get help_hint_manualBadge;

  /// No description provided for @help_hint_removeMode.
  ///
  /// In en, this message translates to:
  /// **'When on, a scan or a number removes the player instead of adding them.'**
  String get help_hint_removeMode;

  /// No description provided for @help_hint_sessionNumber.
  ///
  /// In en, this message translates to:
  /// **'No card at hand: type the player\'s number, then Enter.'**
  String get help_hint_sessionNumber;

  /// No description provided for @help_hint_groupNumber.
  ///
  /// In en, this message translates to:
  /// **'Type a player\'s number, then Enter, to add them without their card.'**
  String get help_hint_groupNumber;

  /// No description provided for @page_playerList_legend.
  ///
  /// In en, this message translates to:
  /// **'Tokens = badged sessions + bonus: the player\'s chances in the draw. A grey bubble has no token — the player is not in the urn.'**
  String get page_playerList_legend;

  /// No description provided for @help_eventList_1.
  ///
  /// In en, this message translates to:
  /// **'This page lists your events — one per edition of the Marathon. Everything else in the application works on the event chosen at the top right.'**
  String get help_eventList_1;

  /// No description provided for @help_eventList_2.
  ///
  /// In en, this message translates to:
  /// **'Create an event with this button: its name, dates, session duration and interval. Sessions are generated by themselves.'**
  String get help_eventList_2;

  /// No description provided for @help_eventList_3.
  ///
  /// In en, this message translates to:
  /// **'Find an event by its name.'**
  String get help_eventList_3;

  /// No description provided for @help_eventList_4.
  ///
  /// In en, this message translates to:
  /// **'Click an event to edit it: dates, card protection, deleting players, backup file. The arrow at the end of the line closes it — its backup file remains.'**
  String get help_eventList_4;

  /// No description provided for @help_eventList_5.
  ///
  /// In en, this message translates to:
  /// **'Choose here the event you are working on: players, sessions, draws and cards are its own.'**
  String get help_eventList_5;

  /// No description provided for @help_eventList_6.
  ///
  /// In en, this message translates to:
  /// **'Wherever you are, scanning a card opens the player\'s sheet; the result of the last scan shows here.'**
  String get help_eventList_6;

  /// No description provided for @help_playerList_1.
  ///
  /// In en, this message translates to:
  /// **'Players are anonymous: each one is a card number. This page creates them and tracks their tokens.'**
  String get help_playerList_1;

  /// No description provided for @help_playerList_2.
  ///
  /// In en, this message translates to:
  /// **'Enter how many cards you print, then \"Generate missing players\": the missing numbers are created.'**
  String get help_playerList_2;

  /// No description provided for @help_playerList_3.
  ///
  /// In en, this message translates to:
  /// **'One card per player: their number, badged sessions, bonus, tokens. Click it to open their sheet.'**
  String get help_playerList_3;

  /// No description provided for @help_playerList_3_empty.
  ///
  /// In en, this message translates to:
  /// **'Players will appear here, one card each, once you have generated them.'**
  String get help_playerList_3_empty;

  /// No description provided for @help_playerList_4.
  ///
  /// In en, this message translates to:
  /// **'\"+\" and \"−\" on the Bonus line give or take sessions: one token more or less in the draw.'**
  String get help_playerList_4;

  /// No description provided for @help_playerList_5.
  ///
  /// In en, this message translates to:
  /// **'Tokens = sessions + bonus: the player\'s chances in the draw. A grey bubble has no token.'**
  String get help_playerList_5;

  /// No description provided for @help_playerList_6.
  ///
  /// In en, this message translates to:
  /// **'Scanning a card opens that player\'s sheet.'**
  String get help_playerList_6;

  /// No description provided for @help_playerGroupList_1.
  ///
  /// In en, this message translates to:
  /// **'A group gathers players for the draws, and nothing else: a draw can require or exclude its members.'**
  String get help_playerGroupList_1;

  /// No description provided for @help_playerGroupList_2.
  ///
  /// In en, this message translates to:
  /// **'Create a group: a name is enough. Players are added on its page afterwards.'**
  String get help_playerGroupList_2;

  /// No description provided for @help_playerGroupList_3.
  ///
  /// In en, this message translates to:
  /// **'Click a group to open its page; the pencil renames it, the bin deletes it (its players remain).'**
  String get help_playerGroupList_3;

  /// No description provided for @help_playerGroupList_3_empty.
  ///
  /// In en, this message translates to:
  /// **'Your groups will appear here.'**
  String get help_playerGroupList_3_empty;

  /// No description provided for @help_playerGroupList_4.
  ///
  /// In en, this message translates to:
  /// **'Winner groups are not listed: they live in the draw that created them.'**
  String get help_playerGroupList_4;

  /// No description provided for @help_playerGroupList_5.
  ///
  /// In en, this message translates to:
  /// **'Here, scanning a card opens the player\'s sheet. On a group\'s page, it adds them to the group.'**
  String get help_playerGroupList_5;

  /// No description provided for @help_playerGroup_1.
  ///
  /// In en, this message translates to:
  /// **'A group\'s page: its members, and how to add or remove them.'**
  String get help_playerGroup_1;

  /// No description provided for @help_playerGroup_2.
  ///
  /// In en, this message translates to:
  /// **'Scan a player\'s card: they join the group. Already a member, nothing changes.'**
  String get help_playerGroup_2;

  /// No description provided for @help_playerGroup_3.
  ///
  /// In en, this message translates to:
  /// **'No card: type their number, then Enter or \"Add\".'**
  String get help_playerGroup_3;

  /// No description provided for @help_playerGroup_4.
  ///
  /// In en, this message translates to:
  /// **'Remove mode: a scan or a number removes the player, and each bubble gets a \"Remove\" button.'**
  String get help_playerGroup_4;

  /// No description provided for @help_playerGroup_5.
  ///
  /// In en, this message translates to:
  /// **'The group\'s members, by number.'**
  String get help_playerGroup_5;

  /// No description provided for @help_playerGroup_6.
  ///
  /// In en, this message translates to:
  /// **'The pencil renames the group, or deletes it.'**
  String get help_playerGroup_6;

  /// No description provided for @help_sessionList_1.
  ///
  /// In en, this message translates to:
  /// **'A session is a badging time slot. Players who are there scan their card: each badged session is worth one token in the draw.'**
  String get help_sessionList_1;

  /// No description provided for @help_sessionList_2.
  ///
  /// In en, this message translates to:
  /// **'The application\'s time: it decides which session is open.'**
  String get help_sessionList_2;

  /// No description provided for @help_sessionList_3_open.
  ///
  /// In en, this message translates to:
  /// **'The open session is coloured: this is where the scanner badges right now. Click a card to open its session.'**
  String get help_sessionList_3_open;

  /// No description provided for @help_sessionList_3_closed.
  ///
  /// In en, this message translates to:
  /// **'No session is open at this time: the scanner does not badge. Click a card to open a session and badge by hand.'**
  String get help_sessionList_3_closed;

  /// No description provided for @help_sessionList_3_empty.
  ///
  /// In en, this message translates to:
  /// **'Sessions are generated from the event: its dates, session duration and interval.'**
  String get help_sessionList_3_empty;

  /// No description provided for @help_sessionList_4.
  ///
  /// In en, this message translates to:
  /// **'From this page, scanning a card badges the open session, without opening it.'**
  String get help_sessionList_4;

  /// No description provided for @help_sessionList_5.
  ///
  /// In en, this message translates to:
  /// **'The colours: open, past, upcoming. \"n present\" counts the badged players.'**
  String get help_sessionList_5;

  /// No description provided for @help_session_1.
  ///
  /// In en, this message translates to:
  /// **'A session\'s page: who is here, who is missing, and the ways to badge.'**
  String get help_session_1;

  /// No description provided for @help_session_2.
  ///
  /// In en, this message translates to:
  /// **'The time slot, its state (open, past) and the time.'**
  String get help_session_2;

  /// No description provided for @help_session_3.
  ///
  /// In en, this message translates to:
  /// **'Scan a card: the player moves to Present. Outside the time slot the scan is refused — unless manual badging is on.'**
  String get help_session_3;

  /// No description provided for @help_session_4.
  ///
  /// In en, this message translates to:
  /// **'Manual badging: to badge outside the time slot — a latecomer, a past session.'**
  String get help_session_4;

  /// No description provided for @help_session_5.
  ///
  /// In en, this message translates to:
  /// **'No card: the player\'s number, then Enter or \"Add\".'**
  String get help_session_5;

  /// No description provided for @help_session_6.
  ///
  /// In en, this message translates to:
  /// **'Remove mode: a scan, a number or a bubble\'s \"Remove\" button takes the player out of the session.'**
  String get help_session_6;

  /// No description provided for @help_session_7.
  ///
  /// In en, this message translates to:
  /// **'Present: the players badged on this session.'**
  String get help_session_7;

  /// No description provided for @help_session_8.
  ///
  /// In en, this message translates to:
  /// **'Absent: those who badged another session, but not this one. A player never badged does not appear.'**
  String get help_session_8;

  /// No description provided for @help_session_9.
  ///
  /// In en, this message translates to:
  /// **'Back to the session list.'**
  String get help_session_9;

  /// No description provided for @help_drawList_1.
  ///
  /// In en, this message translates to:
  /// **'A draw picks winners at random among the players: the more tokens a player has, the better their chances.'**
  String get help_drawList_1;

  /// No description provided for @help_drawList_2.
  ///
  /// In en, this message translates to:
  /// **'Create a draw: number of winners, required or excluded sessions and groups, then \"Draw\".'**
  String get help_drawList_2;

  /// No description provided for @help_drawList_3.
  ///
  /// In en, this message translates to:
  /// **'Click a draw to view or edit it.'**
  String get help_drawList_3;

  /// No description provided for @help_drawList_3_empty.
  ///
  /// In en, this message translates to:
  /// **'Your draws will appear here, with their winners.'**
  String get help_drawList_3_empty;

  /// No description provided for @help_drawList_3_drawn.
  ///
  /// In en, this message translates to:
  /// **'A padlock: the draw is done and can no longer be edited. Its winners are shown; click one to open their sheet.'**
  String get help_drawList_3_drawn;

  /// No description provided for @help_drawList_4.
  ///
  /// In en, this message translates to:
  /// **'Copy takes a draw\'s settings into a new one — to draw again with the same rules.'**
  String get help_drawList_4;

  /// No description provided for @help_drawList_5.
  ///
  /// In en, this message translates to:
  /// **'Scanning a card opens the player\'s sheet.'**
  String get help_drawList_5;

  /// No description provided for @help_cardGenerator_1.
  ///
  /// In en, this message translates to:
  /// **'This page prepares the cards to print: a background image, each player\'s code, their number.'**
  String get help_cardGenerator_1;

  /// No description provided for @help_cardGenerator_2.
  ///
  /// In en, this message translates to:
  /// **'Choose the background image by clicking the frame. The card height follows its proportions.'**
  String get help_cardGenerator_2;

  /// No description provided for @help_cardGenerator_3.
  ///
  /// In en, this message translates to:
  /// **'The sheet: how many cards per row and per page, their width, the margins.'**
  String get help_cardGenerator_3;

  /// No description provided for @help_cardGenerator_4.
  ///
  /// In en, this message translates to:
  /// **'The card\'s code: its size and position, in millimetres from the top left corner.'**
  String get help_cardGenerator_4;

  /// No description provided for @help_cardGenerator_5.
  ///
  /// In en, this message translates to:
  /// **'The number: the same, plus the font and colour.'**
  String get help_cardGenerator_5;

  /// No description provided for @help_cardGenerator_6.
  ///
  /// In en, this message translates to:
  /// **'From number… to number…: the cards to print. Beyond the existing players, a button creates them.'**
  String get help_cardGenerator_6;

  /// No description provided for @help_cardGenerator_7.
  ///
  /// In en, this message translates to:
  /// **'The quick preview follows your settings; the PDF preview is what gets printed, with its print button.'**
  String get help_cardGenerator_7;

  /// No description provided for @help_cardGenerator_8.
  ///
  /// In en, this message translates to:
  /// **'Save: the settings are kept with the event.'**
  String get help_cardGenerator_8;

  /// No description provided for @help_guide_menuItem.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get help_guide_menuItem;

  /// No description provided for @help_guide_title.
  ///
  /// In en, this message translates to:
  /// **'Guide — an edition from start to finish'**
  String get help_guide_title;

  /// No description provided for @help_guide_intro.
  ///
  /// In en, this message translates to:
  /// **'An edition of the Marathon runs in six steps, in the order of the pages in the left rail. Each page has its own \"i\" at the top right for the details.'**
  String get help_guide_intro;

  /// No description provided for @help_guide_where_title.
  ///
  /// In en, this message translates to:
  /// **'Where to find help'**
  String get help_guide_where_title;

  /// No description provided for @help_guide_where_hint.
  ///
  /// In en, this message translates to:
  /// **'A small \"i\" next to a field or a switch: hover it, one sentence explains it.'**
  String get help_guide_where_hint;

  /// No description provided for @help_guide_where_legend.
  ///
  /// In en, this message translates to:
  /// **'A text in the screen, under a list or a form: the legend of what you see.'**
  String get help_guide_where_legend;

  /// No description provided for @help_guide_where_tour.
  ///
  /// In en, this message translates to:
  /// **'The \"i\" at the top right of each page: a step-by-step tour of the screen, area by area.'**
  String get help_guide_where_tour;

  /// No description provided for @help_guide_step_1_title.
  ///
  /// In en, this message translates to:
  /// **'Create the event'**
  String get help_guide_step_1_title;

  /// No description provided for @help_guide_step_1_text.
  ///
  /// In en, this message translates to:
  /// **'Name, start, end, session duration and interval: the preview shows the sessions that will be created, they are generated by themselves. Give it a backup file: the application rewrites it after every change, and \"Open a backup file\" brings the whole event back on another computer. Then choose this event at the top right of the other pages.'**
  String get help_guide_step_1_text;

  /// No description provided for @help_guide_step_2_title.
  ///
  /// In en, this message translates to:
  /// **'Generate the players'**
  String get help_guide_step_2_title;

  /// No description provided for @help_guide_step_2_text.
  ///
  /// In en, this message translates to:
  /// **'Enter how many cards you print: one player per number, anonymous. Each player collects tokens — their chances in the draw.'**
  String get help_guide_step_2_text;

  /// No description provided for @help_guide_step_3_title.
  ///
  /// In en, this message translates to:
  /// **'Print the cards'**
  String get help_guide_step_3_title;

  /// No description provided for @help_guide_step_3_text.
  ///
  /// In en, this message translates to:
  /// **'In the Card generator: a background image, the code and the number placed on it, then printing. Each player gets their card.'**
  String get help_guide_step_3_text;

  /// No description provided for @help_guide_step_4_title.
  ///
  /// In en, this message translates to:
  /// **'Badge at every session'**
  String get help_guide_step_4_title;

  /// No description provided for @help_guide_step_4_text.
  ///
  /// In en, this message translates to:
  /// **'During the open session (coloured), the players who are there scan their card: one token per badged session.'**
  String get help_guide_step_4_text;

  /// No description provided for @help_guide_step_5_title.
  ///
  /// In en, this message translates to:
  /// **'Gather players (optional)'**
  String get help_guide_step_5_title;

  /// No description provided for @help_guide_step_5_text.
  ///
  /// In en, this message translates to:
  /// **'A group is for the draws, and nothing else: a draw can require or exclude its members.'**
  String get help_guide_step_5_text;

  /// No description provided for @help_guide_step_6_title.
  ///
  /// In en, this message translates to:
  /// **'Draw the winners'**
  String get help_guide_step_6_title;

  /// No description provided for @help_guide_step_6_text.
  ///
  /// In en, this message translates to:
  /// **'Number of winners, required or excluded sessions or groups, then \"Draw\": the more tokens a player has, the better their chances. The winners are shown, the draw locks.'**
  String get help_guide_step_6_text;

  /// No description provided for @help_guide_open.
  ///
  /// In en, this message translates to:
  /// **'Open the {page} page'**
  String help_guide_open(Object page);

  /// No description provided for @help_guide_sample_event.
  ///
  /// In en, this message translates to:
  /// **'Board Game Marathon 2026'**
  String get help_guide_sample_event;

  /// No description provided for @help_guide_sample_group.
  ///
  /// In en, this message translates to:
  /// **'The regulars'**
  String get help_guide_sample_group;

  /// No description provided for @backup_title.
  ///
  /// In en, this message translates to:
  /// **'Backup file'**
  String get backup_title;

  /// No description provided for @backup_help.
  ///
  /// In en, this message translates to:
  /// **'The application rewrites this file by itself after every change: players, badges, groups, draws, card image. Keep it in a synced folder or on a USB stick: it brings the event back on another computer.'**
  String get backup_help;

  /// No description provided for @backup_none.
  ///
  /// In en, this message translates to:
  /// **'No file: this event is not backed up.'**
  String get backup_none;

  /// No description provided for @backup_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose…'**
  String get backup_choose;

  /// No description provided for @backup_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get backup_remove;

  /// No description provided for @backup_lastWritten.
  ///
  /// In en, this message translates to:
  /// **'Last backup at {time}'**
  String backup_lastWritten(Object time);

  /// No description provided for @backup_notYetWritten.
  ///
  /// In en, this message translates to:
  /// **'Not written yet — at the next change, or when saving.'**
  String get backup_notYetWritten;

  /// No description provided for @backup_suggestedName.
  ///
  /// In en, this message translates to:
  /// **'{name}.marathon.json'**
  String backup_suggestedName(Object name);

  /// No description provided for @backup_writeError.
  ///
  /// In en, this message translates to:
  /// **'Backup failed for \"{name}\": check the file\'s folder.'**
  String backup_writeError(Object name);

  /// No description provided for @backup_pathLost.
  ///
  /// In en, this message translates to:
  /// **'The backup folder of \"{name}\" no longer exists: choose a new one in the event.'**
  String backup_pathLost(Object name);

  /// No description provided for @backup_open.
  ///
  /// In en, this message translates to:
  /// **'Open a backup file'**
  String get backup_open;

  /// No description provided for @backup_opened.
  ///
  /// In en, this message translates to:
  /// **'Event \"{name}\" added'**
  String backup_opened(Object name);

  /// No description provided for @backup_replaced.
  ///
  /// In en, this message translates to:
  /// **'Event \"{name}\" replaced'**
  String backup_replaced(Object name);

  /// No description provided for @backup_unreadable.
  ///
  /// In en, this message translates to:
  /// **'This file is not a readable backup file.'**
  String get backup_unreadable;

  /// No description provided for @backup_exists_title.
  ///
  /// In en, this message translates to:
  /// **'This event is already here'**
  String get backup_exists_title;

  /// No description provided for @backup_exists_text.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" is already in the list. Replace it with the file\'s content? What was done since in the application will be lost.'**
  String backup_exists_text(Object name);

  /// No description provided for @backup_replace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get backup_replace;

  /// No description provided for @help_eventList_7.
  ///
  /// In en, this message translates to:
  /// **'Open a backup file to bring an event back — after a dead computer, or from another one. Each event chooses its file in its editor.'**
  String get help_eventList_7;

  /// No description provided for @event_close.
  ///
  /// In en, this message translates to:
  /// **'Close the event'**
  String get event_close;

  /// No description provided for @event_close_title.
  ///
  /// In en, this message translates to:
  /// **'Close \"{name}\"?'**
  String event_close_title(Object name);

  /// No description provided for @event_close_saved_text.
  ///
  /// In en, this message translates to:
  /// **'Its backup file remains: {path}. \"Open a backup file\" will bring it back.'**
  String event_close_saved_text(Object path);

  /// No description provided for @event_close_unsaved_title.
  ///
  /// In en, this message translates to:
  /// **'This event is not backed up'**
  String get event_close_unsaved_title;

  /// No description provided for @event_close_unsaved_text.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" and all its data — players, badges, groups, draws — will be lost. Choose a backup file first, or close anyway.'**
  String event_close_unsaved_text(Object name);

  /// No description provided for @event_close_confirm.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get event_close_confirm;

  /// No description provided for @event_close_anyway.
  ///
  /// In en, this message translates to:
  /// **'Close anyway'**
  String get event_close_anyway;

  /// No description provided for @event_closed.
  ///
  /// In en, this message translates to:
  /// **'Event \"{name}\" closed'**
  String event_closed(Object name);

  /// No description provided for @event_closed_saved.
  ///
  /// In en, this message translates to:
  /// **'Event \"{name}\" closed — its backup file: {path}'**
  String event_closed_saved(Object name, Object path);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'fr':
      return SFr();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
