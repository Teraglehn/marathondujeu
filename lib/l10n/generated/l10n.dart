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
    Locale('fr')
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

  /// No description provided for @utils_button_save_and_draw.
  ///
  /// In en, this message translates to:
  /// **'Save and draw'**
  String get utils_button_save_and_draw;

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

  /// No description provided for @page_sessionList_generateSessions.
  ///
  /// In en, this message translates to:
  /// **'Generate sessions'**
  String get page_sessionList_generateSessions;

  /// No description provided for @page_sessionList_deleteSessions.
  ///
  /// In en, this message translates to:
  /// **'Delete sessions'**
  String get page_sessionList_deleteSessions;

  /// No description provided for @page_session_title.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get page_session_title;

  /// No description provided for @page_session_manualAdd.
  ///
  /// In en, this message translates to:
  /// **'Manual mode'**
  String get page_session_manualAdd;

  /// No description provided for @page_session_manualAddActive.
  ///
  /// In en, this message translates to:
  /// **'Manual mode - active'**
  String get page_session_manualAddActive;

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

  /// No description provided for @page_eventList_generateSessions.
  ///
  /// In en, this message translates to:
  /// **'Generate sessions (deletes existing sessions)'**
  String get page_eventList_generateSessions;

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
  /// **'Please select an Event'**
  String get widget_eventSelectedGuard_pleaseSelectEvent;

  /// No description provided for @widget_eventSelector_selectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select event'**
  String get widget_eventSelector_selectTitle;

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

  /// No description provided for @message_player_scanned.
  ///
  /// In en, this message translates to:
  /// **'Player {pnumber} has been scanned'**
  String message_player_scanned(Object pnumber);
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
      'that was used.');
}
