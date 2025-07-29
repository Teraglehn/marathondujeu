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
  String get data_player_error_name_required => 'Name is required';

  @override
  String get page_playerList_title => 'Players';

  @override
  String get page_playerList_menuItem => 'Players';

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
}
