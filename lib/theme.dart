import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f6681),
      surfaceTint: Color(0xff0f6681),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbce9ff),
      onPrimaryContainer: Color(0xff001f29),
      secondary: Color(0xff4c616b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcfe6f2),
      onSecondaryContainer: Color(0xff081e27),
      tertiary: Color(0xff5c5b7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe2dfff),
      onTertiaryContainer: Color(0xff191836),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdce4e9),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787d),
      outlineVariant: Color(0xffc0c8cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inverseOnSurface: Color(0xffedf1f5),
      inversePrimary: Color(0xff8ad0ee),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff001f29),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff004d63),
      secondaryFixed: Color(0xffcfe6f2),
      onSecondaryFixed: Color(0xff081e27),
      secondaryFixedDim: Color(0xffb4cad5),
      onSecondaryFixedVariant: Color(0xff354a53),
      tertiaryFixed: Color(0xffe2dfff),
      onTertiaryFixed: Color(0xff191836),
      tertiaryFixedDim: Color(0xffc5c3ea),
      onTertiaryFixedVariant: Color(0xff444364),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme(), getLightExtensions());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00495e),
      surfaceTint: Color(0xff0f6681),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff327d98),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff31464f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff627882),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff404060),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff727195),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1f),
      surfaceVariant: Color(0xffdce4e9),
      onSurfaceVariant: Color(0xff3c4448),
      outline: Color(0xff586065),
      outlineVariant: Color(0xff747c80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inverseOnSurface: Color(0xffedf1f5),
      inversePrimary: Color(0xff8ad0ee),
      primaryFixed: Color(0xff327d98),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff08647e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff627882),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a5f69),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff727195),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5a597b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme(), getLightMediumContrastExtensions());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002632),
      surfaceTint: Color(0xff0f6681),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00495e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0f252d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff31464f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1f1f3e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff404060),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fafd),
      onBackground: Color(0xff171c1f),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdce4e9),
      onSurfaceVariant: Color(0xff1d2529),
      outline: Color(0xff3c4448),
      outlineVariant: Color(0xff3c4448),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffd4f0ff),
      primaryFixed: Color(0xff00495e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003140),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff31464f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1b2f38),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff404060),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2a2949),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme(), getLightHighContrastExtensions());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ad0ee),
      surfaceTint: Color(0xff8ad0ee),
      onPrimary: Color(0xff003545),
      primaryContainer: Color(0xff004d63),
      onPrimaryContainer: Color(0xffbce9ff),
      secondary: Color(0xffb4cad5),
      onSecondary: Color(0xff1e333c),
      secondaryContainer: Color(0xff354a53),
      onSecondaryContainer: Color(0xffcfe6f2),
      tertiary: Color(0xffc5c3ea),
      onTertiary: Color(0xff2e2d4d),
      tertiaryContainer: Color(0xff444364),
      onTertiaryContainer: Color(0xffe2dfff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdee3e6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdee3e6),
      surfaceVariant: Color(0xff40484c),
      onSurfaceVariant: Color(0xffc0c8cc),
      outline: Color(0xff8a9296),
      outlineVariant: Color(0xff40484c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inverseOnSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff0f6681),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff001f29),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff004d63),
      secondaryFixed: Color(0xffcfe6f2),
      onSecondaryFixed: Color(0xff081e27),
      secondaryFixedDim: Color(0xffb4cad5),
      onSecondaryFixedVariant: Color(0xff354a53),
      tertiaryFixed: Color(0xffe2dfff),
      onTertiaryFixed: Color(0xff191836),
      tertiaryFixedDim: Color(0xffc5c3ea),
      onTertiaryFixedVariant: Color(0xff444364),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme(), getDarkExtensions());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ed4f3),
      surfaceTint: Color(0xff8ad0ee),
      onPrimary: Color(0xff001922),
      primaryContainer: Color(0xff5299b6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb8ceda),
      onSecondary: Color(0xff031921),
      secondaryContainer: Color(0xff7e949f),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc9c7ef),
      onTertiary: Color(0xff131331),
      tertiaryContainer: Color(0xff8f8db2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdee3e6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xfff7fbff),
      surfaceVariant: Color(0xff40484c),
      onSurfaceVariant: Color(0xffc4ccd1),
      outline: Color(0xff9ca4a9),
      outlineVariant: Color(0xff7c8489),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inverseOnSurface: Color(0xff262b2d),
      inversePrimary: Color(0xff004e65),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff00131b),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff003b4d),
      secondaryFixed: Color(0xffcfe6f2),
      onSecondaryFixed: Color(0xff00131b),
      secondaryFixedDim: Color(0xffb4cad5),
      onSecondaryFixedVariant: Color(0xff243942),
      tertiaryFixed: Color(0xffe2dfff),
      onTertiaryFixed: Color(0xff0e0d2c),
      tertiaryFixedDim: Color(0xffc5c3ea),
      onTertiaryFixedVariant: Color(0xff343353),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme(), getDarkMediumContrastExtensions());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff6fbff),
      surfaceTint: Color(0xff8ad0ee),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8ed4f3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff6fbff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb8ceda),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffdf9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc9c7ef),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdee3e6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff40484c),
      onSurfaceVariant: Color(0xfff6fbff),
      outline: Color(0xffc4ccd1),
      outlineVariant: Color(0xffc4ccd1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002e3d),
      primaryFixed: Color(0xffc7edff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8ed4f3),
      onPrimaryFixedVariant: Color(0xff001922),
      secondaryFixed: Color(0xffd4eaf6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb8ceda),
      onSecondaryFixedVariant: Color(0xff031921),
      tertiaryFixed: Color(0xffe7e4ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc9c7ef),
      onTertiaryFixedVariant: Color(0xff131331),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme(), getDarkHighContrastExtensions());
  }

  ThemeData theme(ColorScheme colorScheme, Iterable<ThemeExtension<dynamic>> extensions) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        extensions: extensions,
      );


  static List<CustomColors> getLightExtensions(){
    return getExtensions((ExtendedColor colors) => colors.light);
  }

  static List<CustomColors> getLightMediumContrastExtensions(){
    return getExtensions((ExtendedColor colors) => colors.lightMediumContrast);
  }

  static List<CustomColors> getLightHighContrastExtensions(){
    return getExtensions((ExtendedColor colors) => colors.lightHighContrast);
  }

  static List<CustomColors> getDarkExtensions(){
    return getExtensions((ExtendedColor colors) => colors.dark);
  }

  static List<CustomColors> getDarkMediumContrastExtensions(){
    return getExtensions((ExtendedColor colors) => colors.darkMediumContrast);
  }

  static List<CustomColors> getDarkHighContrastExtensions(){
    return getExtensions((ExtendedColor colors) => colors.darkHighContrast);
  }

  static List<CustomColors> getExtensions(ColorFamily Function(ExtendedColor) fromBrightness){
    return [
      CustomColors(
        positive: fromBrightness(positive), 
        error: fromBrightness(error), 
        info: fromBrightness(info),
        warning: fromBrightness(warning))
    ];
  }

  /// Positive
  static const positive = ExtendedColor(
    seed: Color(0xff4caf50),
    value: Color(0xff4caf50),
    light: ColorFamily(
      color: Color(0xff3b6939),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbcf0b4),
      onColorContainer: Color(0xff002204),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff3b6939),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbcf0b4),
      onColorContainer: Color(0xff002204),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff3b6939),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffbcf0b4),
      onColorContainer: Color(0xff002204),
    ),
    dark: ColorFamily(
      color: Color(0xffa1d39a),
      onColor: Color(0xff0a390f),
      colorContainer: Color(0xff235024),
      onColorContainer: Color(0xffbcf0b4),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa1d39a),
      onColor: Color(0xff0a390f),
      colorContainer: Color(0xff235024),
      onColorContainer: Color(0xffbcf0b4),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffa1d39a),
      onColor: Color(0xff0a390f),
      colorContainer: Color(0xff235024),
      onColorContainer: Color(0xffbcf0b4),
    ),
  );

  /// Error
  static const error = ExtendedColor(
    seed: Color(0xffe53935),
    value: Color(0xffe53935),
    light: ColorFamily(
      color: Color(0xff904a44),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad6),
      onColorContainer: Color(0xff3b0907),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff904a44),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad6),
      onColorContainer: Color(0xff3b0907),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff904a44),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad6),
      onColorContainer: Color(0xff3b0907),
    ),
    dark: ColorFamily(
      color: Color(0xffffb4ac),
      onColor: Color(0xff561e1a),
      colorContainer: Color(0xff73332e),
      onColorContainer: Color(0xffffdad6),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb4ac),
      onColor: Color(0xff561e1a),
      colorContainer: Color(0xff73332e),
      onColorContainer: Color(0xffffdad6),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb4ac),
      onColor: Color(0xff561e1a),
      colorContainer: Color(0xff73332e),
      onColorContainer: Color(0xffffdad6),
    ),
  );

  /// Info
  static const info = ExtendedColor(
    seed: Color(0xff2096f3),
    value: Color(0xff2096f3),
    light: ColorFamily(
      color: Color(0xff36618e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd1e4ff),
      onColorContainer: Color(0xff001d36),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff36618e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd1e4ff),
      onColorContainer: Color(0xff001d36),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff36618e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd1e4ff),
      onColorContainer: Color(0xff001d36),
    ),
    dark: ColorFamily(
      color: Color(0xffa0cafd),
      onColor: Color(0xff003258),
      colorContainer: Color(0xff194975),
      onColorContainer: Color(0xffd1e4ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa0cafd),
      onColor: Color(0xff003258),
      colorContainer: Color(0xff194975),
      onColorContainer: Color(0xffd1e4ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffa0cafd),
      onColor: Color(0xff003258),
      colorContainer: Color(0xff194975),
      onColorContainer: Color(0xffd1e4ff),
    ),
  );

  /// Warning
  static const warning = ExtendedColor(
    seed: Color(0xfff9a826),
    value: Color(0xfff9a826),
    light: ColorFamily(
      color: Color(0xff815511),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffddb5),
      onColorContainer: Color(0xff2a1800),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff815511),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffddb5),
      onColorContainer: Color(0xff2a1800),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff815511),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffddb5),
      onColorContainer: Color(0xff2a1800),
    ),
    dark: ColorFamily(
      color: Color(0xfff6bc70),
      onColor: Color(0xff462b00),
      colorContainer: Color(0xff643f00),
      onColorContainer: Color(0xffffddb5),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xfff6bc70),
      onColor: Color(0xff462b00),
      colorContainer: Color(0xff643f00),
      onColorContainer: Color(0xffffddb5),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfff6bc70),
      onColor: Color(0xff462b00),
      colorContainer: Color(0xff643f00),
      onColorContainer: Color(0xffffddb5),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        positive,
        error,
        info,
        warning,
      ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;

  ColorFamily lerp(ColorFamily other, double t) {
    return ColorFamily(
      color: Color.lerp(color, other.color, t)!,
      onColor: Color.lerp(onColor, other.onColor, t)!,
      colorContainer: Color.lerp(colorContainer, other.colorContainer, t)!,
      onColorContainer: Color.lerp(onColorContainer, other.onColorContainer, t)!,
    );
  }
}

class CustomColors extends ThemeExtension<CustomColors> {
  final ColorFamily positive;
  final ColorFamily error;
  final ColorFamily info;
  final ColorFamily warning;

  const CustomColors({
    required this.positive,
    required this.error,
    required this.info,
    required this.warning,
  });

  @override
  CustomColors lerp(CustomColors other, double t) {
    return CustomColors(
      positive: positive.lerp(other.positive, t),
      error: error.lerp(other.error, t),
      info: info.lerp(other.info, t),
      warning: warning.lerp(other.warning, t),
    );
  }

  @override
  ThemeExtension<CustomColors> copyWith({
    ColorFamily? positive,
    ColorFamily? error,
    ColorFamily? info,
    ColorFamily? warning,
  }) {
    return CustomColors(
      positive: positive ?? this.positive,
      error: error ?? this.error,
      info: info ?? this.info,
      warning: warning ?? this.warning,
    );
  }
} 