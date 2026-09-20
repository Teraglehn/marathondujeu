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
