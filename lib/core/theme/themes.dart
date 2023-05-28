library theme;

import 'package:flutter/material.dart';

part 'constants/font_sizes.dart';
part 'constants/my_colors.dart';
part 'constants/sizes.dart';
part 'constants/spacing.dart';

class Themes {
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32.0),
    displayMedium: TextStyle(fontSize: 28.0),
    displaySmall: TextStyle(fontSize: 24.0),
    headlineMedium: TextStyle(fontSize: 20.0),
    headlineSmall: TextStyle(fontSize: 18.0),
    titleLarge: TextStyle(fontSize: 18.0),
    titleMedium: TextStyle(fontSize: 16.0),
    titleSmall: TextStyle(fontSize: 14.0),
    bodyLarge: TextStyle(fontSize: 18.0),
    bodyMedium: TextStyle(fontSize: 16.0),
    bodySmall: TextStyle(fontSize: 14.0),
    labelLarge: TextStyle(fontSize: 18.0),
    labelSmall: TextStyle(fontSize: 12.0),
  );

  static final ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 64), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius))),
  );

  static const PopupMenuThemeData _popupMenuButtonThemeData = PopupMenuThemeData(
    color: MyColors.black,
    position: PopupMenuPosition.under,
    shape: RoundedRectangleBorder(),
    textStyle: TextStyle(color: MyColors.grey),
    surfaceTintColor: Colors.transparent,
    labelTextStyle: MaterialStatePropertyAll(TextStyle(color: MyColors.grey)),
  );

  static final TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(padding: const EdgeInsets.all(12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadius))),
  );

  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
    suffixIconColor: MyColors.blue,
  );

  static const DialogTheme _dialogTheme = DialogTheme(backgroundColor: MyColors.black);

  static const bool _useMaterial3 = true;

  static const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontSize: FontSize.small2,
      color: MyColors.grey,
      fontWeight: FontWeight.w500,
    ),
  );

  static const IconThemeData _iconTheme = IconThemeData(color: MyColors.blue, size: 30);

  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF9ACBFF),
    onPrimary: const Color.fromARGB(255, 69, 177, 248),
    primaryContainer: const Color(0xFF004A79),
    onPrimaryContainer: const Color(0xFFCFE5FF),
    secondary: const Color(0xFFBAC8DA),
    onSecondary: const Color(0xFF243240),
    secondaryContainer: const Color(0xFF3A4857),
    onSecondaryContainer: const Color(0xFFD6E4F7),
    tertiary: const Color(0xFFD4BEE6),
    onTertiary: const Color(0xFF392A49),
    tertiaryContainer: const Color(0xFF514060),
    onTertiaryContainer: const Color(0xFFF0DBFF),
    error: const Color(0xFFFFB4AB),
    errorContainer: const Color(0xFF93000A),
    onError: const Color(0xFF690005),
    onErrorContainer: const Color(0xFFFFDAD6),
    background: Colors.transparent,
    onBackground: MyColors.black,
    surface: MyColors.blue[100] as Color,
    onSurface: const Color(0xFFC6C6CA),
    surfaceVariant: MyColors.grey[50],
    onSurfaceVariant: const Color(0xFFC2C7CF),
    outline: const Color(0xFF8C9199),
    onInverseSurface: const Color.fromARGB(255, 39, 133, 228),
    inverseSurface: const Color(0xFFE2E2E5),
    inversePrimary: const Color(0xFF00629E),
    shadow: const Color.fromARGB(255, 0, 0, 0),
    surfaceTint: Colors.black,
    outlineVariant: const Color(0xFF42474E),
    scrim: const Color(0xFF000000),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: _useMaterial3,
    appBarTheme: _appBarTheme,
    dialogTheme: _dialogTheme,
    popupMenuTheme: _popupMenuButtonThemeData,
    textTheme: _textTheme,
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _textButtonThemeData,
    inputDecorationTheme: _inputDecorationTheme,
    iconTheme: _iconTheme,
    colorScheme: _darkColorScheme,
  );
}
