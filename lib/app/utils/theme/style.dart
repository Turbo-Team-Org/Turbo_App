// ═══════════════════════════════════════════════════════════════════════════
// 🎨 ESTILOS LEGACY - Integrado con TurboUI
// ═══════════════════════════════════════════════════════════════════════════
//
// @deprecated Este archivo es para compatibilidad con código existente.
// En código nuevo, usar directamente:
//   - TurboColors para colores
//   - TurboSpacing para espaciado
//   - TurboRadius para bordes
//   - Theme.of(context).textTheme para estilos de texto
//
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:turbo_ui/turbo_ui.dart';

class Styles {
  // ══════════════════════════════════════════════════════════════════════════
  // 🎨 COLORES - Mapeados a TurboColors
  // ══════════════════════════════════════════════════════════════════════════
  
  static const colorWhiteOff = TurboColors.neutral50;
  static const colorPrimary = TurboColors.blue;
  static const colorOnPrimary = TurboColors.white;
  static const colorSecondary = TurboColors.teal;
  static const colorSecondaryVariant = TurboColors.amber;
  static const colorOnSecondary = TurboColors.white;
  static const colorMeta = TurboColors.neutral300;
  static const colorLightGrey = TurboColors.neutral200;
  static const colorGrey = TurboColors.neutral600;
  static const colorMidGrey = TurboColors.neutral500;
  static const colorNavIcons = TurboColors.neutral400;
  static const colorDarkGrey = TurboColors.neutral700;
  static const colorPrimaryVariant = TurboColors.primaryDarker;
  static const colorSpinner = AlwaysStoppedAnimation<Color>(TurboColors.blue);
  static const greySpinner = AlwaysStoppedAnimation<Color>(TurboColors.neutral300);
  static const defaultScaffoldColor = TurboColors.lightScaffold;
  static const colorDanger = TurboColors.error;
  static const colorRed = TurboColors.primaryDark;
  
  /// Color principal de Turbo - Usar TurboColors.primary
  static const turboRed = TurboColors.primary;
  
  // Light colors
  static const colorLightOutline = TurboColors.neutral500;
  static const colorLightSecondary = TurboColors.primary;
  static const colorLightSecondaryContainer = TurboColors.primaryLighter;
  static const colorLightTertiary = TurboColors.amber;
  static const colorLightSurfaceVariant = TurboColors.lightSurfaceVariant;
  static const colorLightOnSurfaceVariant = TurboColors.neutral600;
  static const colorLightOnSurface = TurboColors.neutral900;
  static const colorLightOnBackground = TurboColors.neutral900;
  static const colorLightBackground = TurboColors.lightBackground;
  static const colorLightOnLight = TurboColors.white;

  static const backgroundColorLightTheme = TurboColors.lightSurface;
  static const backgroundColorDarkTheme = TurboColors.darkSurface;
  static const googleColor = TurboColors.blue;

  static const colorDarkPrimary = TurboColors.blue;
  static const colorDarkOnPrimary = TurboColors.white;
  static const colorDarkBackground = TurboColors.darkBackground;
  static const colorDarkSurface = TurboColors.darkSurface;
  static const colorDarkOnSurface = TurboColors.neutral100;
  static const colorDarkOutline = TurboColors.neutral600;

  // ══════════════════════════════════════════════════════════════════════════
  // 📝 ESTILOS DE TEXTO - Usar Theme.of(context).textTheme en su lugar
  // ══════════════════════════════════════════════════════════════════════════

  static const textH1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
    color: TurboColors.neutral900,
  );

  static const textBtnCta = TextStyle(
    fontSize: 17,
    color: TurboColors.white,
    letterSpacing: 0.3,
  );

  static const textH2 = TextStyle(
    fontSize: 18.0, 
    color: TurboColors.neutral900,
  );

  static const textAttribute = TextStyle(
    fontSize: 10, 
    color: TurboColors.neutral300,
  );

  static const textListDivider = TextStyle(
    fontSize: 12,
    color: TurboColors.neutral300,
  );

  static const textLabel = TextStyle(
    color: TurboColors.neutral300,
    fontFamily: 'MuseoSans',
    fontSize: 14,
  );
  
  static const textDanger = TextStyle(color: TurboColors.error);

  static const textMeta = TextStyle(
    color: TurboColors.neutral600,
    fontSize: 13,
    fontWeight: FontWeight.w900,
    letterSpacing: 0.18,
    fontFamily: 'MuseoSans',
  );

  static const textMetaDataPrimary = TextStyle(
    color: TurboColors.neutral700,
    fontFamily: 'MuseoSans',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const textMetaDataSecondary = TextStyle(
    color: TurboColors.neutral500,
    fontFamily: 'MuseoSans',
    fontSize: 14,
  );

  static const textTitle = TextStyle(
    fontSize: 22,
    color: TurboColors.white,
    fontFamily: 'MuseoSans',
    fontWeight: FontWeight.w500,
  );

  static const textDisplaySmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const textTitleMedium = TextStyle(
    fontSize: 15,
    fontFamily: 'MuseoSans',
    fontWeight: FontWeight.w500,
    color: TurboColors.neutral900,
  );

  static const textLabelSmall = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'MuseoSans',
    color: TurboColors.neutral500,
    height: 1.42,
  );

  static const textBodyMedium = TextStyle(
    fontSize: 16,
    fontFamily: 'MuseoSans',
    color: TurboColors.primary,
  );

  static const textDisplayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: TurboColors.white,
  );

  static const textDisplayLarge = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w600,
    color: TurboColors.white,
  );

  static const textLabelLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: TurboColors.primary,
    fontFamily: 'MuseoSans',
  );

  static const textLabelMedium = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    fontFamily: 'MuseoSans',
  );

  // ══════════════════════════════════════════════════════════════════════════
  // 🎨 TEMAS - Usar TurboTheme en su lugar
  // ══════════════════════════════════════════════════════════════════════════

  static final ThemeData lightTheme = TurboTheme.light;
  static final ThemeData darkTheme = TurboTheme.dark;

  static const textBodySmall = TextStyle(
    fontSize: 12,
    fontFamily: 'MuseoSans',
    color: TurboColors.neutral500,
  );

  static final textFieldDecoration = InputDecoration(
    isDense: true,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      vertical: TurboSpacing.md,
      horizontal: TurboSpacing.base,
    ),
    labelStyle: const TextStyle(
      fontSize: 24,
      fontFamily: 'MuseoSans',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.50,
    ),
    hintStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.50,
      fontFamily: 'MuseoSans',
      color: TurboColors.neutral300,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: TurboRadius.fullRadius,
      borderSide: const BorderSide(color: TurboColors.primaryDarker),
    ),
    border: OutlineInputBorder(
      borderRadius: TurboRadius.fullRadius,
      borderSide: const BorderSide(
        color: TurboColors.blue,
        width: 2.0,
        style: BorderStyle.none,
      ),
    ),
    fillColor: TurboColors.white,
    hintText: "",
  );

  static final textFieldExpandedDecoration = textFieldDecoration.copyWith(
    enabledBorder: OutlineInputBorder(
      borderRadius: TurboRadius.smRadius,
      borderSide: const BorderSide(color: TurboColors.neutral300),
    ),
    border: OutlineInputBorder(
      borderRadius: TurboRadius.smRadius,
      borderSide: const BorderSide(
        color: TurboColors.blue,
        width: 2.0,
        style: BorderStyle.none,
      ),
    ),
  );

  static const kHintTextStyle = TextStyle(color: TurboColors.neutral300);

  static const kLabelStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'MuseoSans',
  );

  static const textLabelStyle = TextStyle(fontSize: 16);

  static const tileLabelStyle = TextStyle(
    color: TurboColors.neutral900, 
    fontSize: 13,
  );

  static const editLabelStyle = TextStyle(
    color: TurboColors.neutral50,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    fontFamily: 'MuseoSans',
  );

  static const nameLabelStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'MuseoSans',
    fontSize: 20,
  );

  static const headerLabelStyle = TextStyle(
    color: TurboColors.primaryDarker,
    fontWeight: FontWeight.bold,
    fontFamily: 'MuseoSans',
    fontSize: 20,
  );

  static BoxDecoration kBoxDecorationStyle = BoxDecoration(
    color: TurboColors.white,
    border: Border.all(width: 1, color: TurboColors.neutral200),
    borderRadius: BorderRadius.circular(TurboRadius.xxl),
  );

  static const textH1Published = TextStyle(fontSize: 17, letterSpacing: 0.5);

  static const themedSpinner = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(TurboColors.blue),
  );

  // ══════════════════════════════════════════════════════════════════════════
  // 🎨 APP THEME - Usar TurboTheme en su lugar
  // ══════════════════════════════════════════════════════════════════════════
  
  static final appTheme = TurboTheme.light;
}
