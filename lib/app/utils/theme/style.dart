import 'package:flutter/material.dart';

class Styles {
  // colours start with ColorXyz

  static const colorWhiteOff = Color(0xffF2F1F0);
  static const colorPrimary = Color(0xff6FCFF4);
  static const colorOnPrimary = Color(0xffFFFFFF);
  static const colorSecondary = Colors.lime;
  static const colorSecondaryVariant = Color(0xffFBB73A);
  static const colorOnSecondary = Color(0xffFFFFFF);
  static const colorMeta = Color(0xffC6C6C8);
  static const colorLightGrey = Color(0xffD8D8D8);
  static const colorGrey = Color(0xff545454);
  static const colorMidGrey = Color(0xff818181);
  static const colorNavIcons = Color.fromARGB(255, 170, 170, 170);
  static const colorDarkGrey = Color(0xff545454);
  static const colorPrimaryVariant = Color(0xff002F5F);
  static const colorSpinner = AlwaysStoppedAnimation<Color>(colorPrimary);
  static const greySpinner = AlwaysStoppedAnimation<Color>(colorMeta);
  static const defaultScaffoldColor = Color(0xfffafafa);
  static const colorDanger = Color(0xffFF1100);
  static const colorRed = Color(0xffC11534);
  static const turboRed = Color.fromARGB(255, 236, 64, 52);
  // light colors
  static const colorLightOutline = Color(0xff74777F);
  static const colorLightSecondary = Color(0xffC11534);
  static const colorLightSecondaryContainer = Color(0xffFFD9DA);
  static const colorLightTertiary = Color(0xffFDD489);
  static const colorLightSurfaceVariant = Color(0xffE0E2EB);
  static const colorLightOnSurfaceVariant = Color(0xff44474F);
  static const colorLightOnSurface = Color(0xff1B1B1D);
  static const colorLightOnBackground = Color(0xff1B1B1D);
  static const colorLightBackground = Color.fromARGB(255, 253, 253, 253);
  static const colorLightOnLight = Color(0xffFFFFFF);

  static const backgroundColorLightTheme = Color(0xffFFFFFF);
  static const backgroundColorDarkTheme = Color.fromARGB(255, 44, 47, 57);
  static const googleColor = Color.fromARGB(255, 0, 87, 231);

  static const colorDarkPrimary = Color(0xff6FCFF4);
  static const colorDarkOnPrimary = Color(0xffFFFFFF);
  static const colorDarkBackground = Color(0xff121212);
  static const colorDarkSurface = Color(0xff1E1E1E);
  static const colorDarkOnSurface = Color(0xffE0E2EB);
  static const colorDarkOutline = Color(0xff5F6368);

  static const textH1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );

  static const textBtnCta = TextStyle(
    fontSize: 17,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  static const textH2 = TextStyle(fontSize: 18.0, color: Colors.black);

  static const textAttribute = TextStyle(
    fontSize: 10,
    color: colorMeta,
  );

  static const textListDivider = TextStyle(
    fontSize: 12,
    color: Styles.colorMeta,
  );

  static const textLabel = TextStyle(
    color: colorMeta,
    fontFamily: 'Roboto',
    fontSize: 14,
  );
  static const textDanger = TextStyle(color: colorDanger);

  static const textMeta = TextStyle(
    color: colorGrey,
    fontSize: 13,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.18,
    fontFamily: 'roboto',
  );

  static const textMetaDataPrimary = TextStyle(
    color: colorDarkGrey,
    fontFamily: 'Roboto',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const textMetaDataSecondary = TextStyle(
    color: colorMidGrey,
    fontFamily: 'Roboto',
    fontSize: 14,
  );

  static const textTitle = TextStyle(
    fontSize: 22,
    color: Colors.white,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const textDisplaySmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const textTitleMedium = TextStyle(
    fontSize: 15,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const textLabelSmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: colorLightOutline,
    height: 1.42,
  );

  static const textBodyMedium =
      TextStyle(fontSize: 16, fontFamily: 'Roboto', color: Styles.turboRed);

  static const textDisplayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const textDisplayLarge = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const textLabelLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: 'Roboto',
  );

  static const textLabelMedium = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: colorPrimary,
      secondary: colorLightSecondary,
      surface: colorLightBackground,
      onPrimary: colorOnPrimary,
      onSecondary: colorOnSecondary,
      onSurface: colorLightOnSurface,
    ),
    scaffoldBackgroundColor: colorLightBackground,
    appBarTheme: const AppBarTheme(
      color: colorPrimary,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: colorLightOnSurface),
      titleLarge: TextStyle(color: colorLightOnSurface),
      // Add all other text styles as needed
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(colorLightSecondary),
      trackColor: WidgetStateProperty.all(colorLightSecondaryContainer),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF212121),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: colorDarkOnSurface),
      titleLarge: TextStyle(color: colorDarkOnSurface),
      // Add all other text styles as needed
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  static const textBodySmall =
      TextStyle(fontSize: 12, fontFamily: 'Roboto', color: colorLightOutline);

  static final textFieldDecoration = InputDecoration(
    isDense: true,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 12.0,
      horizontal: 16.0,
    ),
    labelStyle: const TextStyle(
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.50,
    ),
    hintStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.50,
      fontFamily: 'Roboto',
      color: Color(0xffC7C6CA),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Styles.colorPrimaryVariant),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(
        color: colorPrimary,
        width: 2.0,
        style: BorderStyle.none,
      ),
    ),
    fillColor: Colors.white,
    hintText: "",
  );

  static final textFieldExpandedDecoration = textFieldDecoration.copyWith(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Styles.colorMeta),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: colorPrimary,
        width: 2.0,
        style: BorderStyle.none,
      ),
    ),
  );

  static const kHintTextStyle = TextStyle(
    color: colorMeta,
  );

  static const kLabelStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static const textLabelStyle = TextStyle(fontSize: 16);

  static const tileLabelStyle = TextStyle(color: Colors.black, fontSize: 13);

  static const editLabelStyle = TextStyle(
    color: colorWhiteOff,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    fontFamily: 'OpenSans',
  );

  static const nameLabelStyle = TextStyle(
      fontWeight: FontWeight.bold, fontFamily: 'OpenSans', fontSize: 20);

  static const headerLabelStyle = TextStyle(
      color: colorPrimaryVariant,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
      fontSize: 20);

  static BoxDecoration kBoxDecorationStyle = BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 1, color: colorLightGrey),
    borderRadius: BorderRadius.circular(30.0),
  );

  static const textH1Published = TextStyle(fontSize: 17, letterSpacing: 0.5);

  static const themedSpinner = CircularProgressIndicator(
    valueColor: Styles.colorSpinner,
  );

  // putting it all together
  static final appTheme = ThemeData(
    colorScheme: const ColorScheme.light(primary: Styles.colorPrimaryVariant),
    // We still need this extra line: https://github.com/flutter/flutter/issues/48195#issuecomment-621558530
    primaryColor: Styles.colorPrimaryVariant,
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
    ),
    primaryIconTheme: const IconThemeData.fallback().copyWith(
      color: Colors.white,
    ),

    // set default font
    fontFamily: 'MuseoSans',

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(
        Styles.colorLightSecondary,
      ),
      trackColor: WidgetStateProperty.all(
        Styles.colorLightSecondaryContainer,
      ),
    ),
  );
}
