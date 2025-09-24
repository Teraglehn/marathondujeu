import 'package:flutter/services.dart';

class FormattersService {
  static TextInputFormatter get signedDecimal => FilteringTextInputFormatter.allow(RegExp(r'^-{0,1}(\d+(\.|,)?\d{0,2}){0,1}$'));
  static TextInputFormatter get integer => FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$'));
}