library theme;

import 'package:flutter/material.dart';

part 'constants/font_sizes.dart';
part 'constants/my_colors.dart';
part 'constants/sizes.dart';
part 'constants/spacing.dart';

abstract class Themes {
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32.0),
    displayMedium: TextStyle(fontSize: 28.0),
    displaySmall: TextStyle(fontSize: 24.0),
    headlineMedium: TextStyle(fontSize: 20.0),
    headlineSmall: TextStyle(fontSize: 18.0),
    titleLarge: TextStyle(fontSize: 18.0),
    titleMedium: TextStyle(fontSize: 16.0),
    titleSmall: TextStyle(fontSize: 14.0),
    bodyLarge: TextStyle(fontSize: 20.0),
    bodyMedium: TextStyle(fontSize: 18.0),
    bodySmall: TextStyle(fontSize: 14.0),
    labelLarge: TextStyle(fontSize: 18.0),
    labelSmall: TextStyle(fontSize: 12.0),
  );

  static const bool _useMaterial3 = true;

  static final DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: MyColors.darkGrey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
  );

  static final PopupMenuThemeData _popupMenuButtonTheme = PopupMenuThemeData(
    color: MyColors.darkGrey,
    position: PopupMenuPosition.under,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius)),
    textStyle: const TextStyle(color: MyColors.lightGrey, fontSize: FontSize.small3),
    surfaceTintColor: Colors.transparent,
    labelTextStyle: const MaterialStatePropertyAll(
      TextStyle(
        color: MyColors.lightGrey,
        fontSize: FontSize.small1,
      ),
    ),
    shadowColor: Colors.transparent,
  );

  static const SnackBarThemeData _snackBarThemeData = SnackBarThemeData(
    backgroundColor: MyColors.darkGrey,
  );

  static const IconThemeData iconThemeData = IconThemeData(color: MyColors.lightGrey);

  static const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontSize: FontSize.small2,
      fontWeight: FontWeight.w500,
    ),
  );

  static final SliderThemeData _sliderThemeData = SliderThemeData(
    overlayShape: SliderComponentShape.noOverlay,
    showValueIndicator: ShowValueIndicator.always,
    valueIndicatorColor: Colors.white,
  );

  static const TimePickerThemeData _timePickerThemeData = TimePickerThemeData(
    backgroundColor: MyColors.darkGrey,
    dialHandColor: MyColors.darkGrey,
  );

  static const ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 78, 176, 200)),
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    // labelStyle: const TextStyle(fontSize: FontSize.small1),
    contentPadding: const EdgeInsets.symmetric(vertical: Spacing.small1, horizontal: Spacing.small2),
    filled: true,
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      borderSide: const BorderSide(width: 0),
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      borderSide: const BorderSide(width: 0),
    ),
    disabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      borderSide: const BorderSide(width: 0),
    ),
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF4E9CC8),
    onPrimary: Color.fromARGB(255, 69, 177, 248),
    primaryContainer: Color(0xFF004A79),
    onPrimaryContainer: Color(0xFFCFE5FF),
    secondary: Color(0xFFBAC8DA),
    onSecondary: Color(0xFF243240),
    secondaryContainer: Color(0xFF3A4857),
    onSecondaryContainer: Color(0xFFD6E4F7),
    tertiary: Color(0xFFD4BEE6),
    onTertiary: Color(0xFF392A49),
    tertiaryContainer: Color(0xFF514060),
    onTertiaryContainer: Color(0xFFF0DBFF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Colors.transparent,
    onBackground: Colors.black,
    surface: MyColors.darkGrey,
    onSurface: MyColors.lightGrey,
    surfaceVariant: Color.fromRGBO(190, 190, 190, .1),
    onSurfaceVariant: Color(0xFFC2C7CF),
    outline: Color(0xFF8C9199),
    onInverseSurface: Color.fromARGB(255, 39, 133, 228),
    inverseSurface: Color(0xFFE2E2E5),
    inversePrimary: Color(0xFF00629E),
    shadow: Color.fromARGB(255, 0, 0, 0),
    surfaceTint: Colors.black,
    outlineVariant: Color(0xFF42474E),
    scrim: Color(0xFF000000),
  );

  static final ThemeData dark = ThemeData(
    dialogTheme: _dialogTheme,
    sliderTheme: _sliderThemeData,
    useMaterial3: _useMaterial3,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
    colorScheme: _darkColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
    timePickerTheme: _timePickerThemeData,
    elevatedButtonTheme: _elevatedButtonThemeData,
    popupMenuTheme: _popupMenuButtonTheme,
    snackBarTheme: _snackBarThemeData,
  );
}
