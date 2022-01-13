import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

ThemeData getApplicationThemeData() {
  return ThemeData(
    iconTheme: IconThemeData(
      color: ColorManager.black,
    ),
    scaffoldBackgroundColor: ColorManager.black,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.black,
    splashColor: ColorManager.black,
    disabledColor: ColorManager.grey,
    // accentColor: ColorManager.grey,
    colorScheme: ColorScheme(
      secondaryVariant: ColorManager.primaryWithOpacity40,
      primary: ColorManager.primary,
      onPrimary: ColorManager.black,
      primaryVariant: ColorManager.black,
      background: ColorManager.black,
      onBackground: ColorManager.black,
      secondary: ColorManager.grey,
      onSecondary: ColorManager.black,
      error: ColorManager.red,
      onError: ColorManager.black,
      surface: ColorManager.black,
      onSurface: ColorManager.black,
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      elevation: AppSize.s4,
      color: ColorManager.black,
      shadowColor: ColorManager.grey,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      color: ColorManager.black,
      elevation: AppSize.s1,
      shadowColor: ColorManager.black,
      titleTextStyle: getRegularStyle(
        color: ColorManager.primary,
        fontSize: 16,
      ),
    ),
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(), buttonColor: ColorManager.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.black,
        ),
        primary: ColorManager.primary,
        minimumSize: const Size.fromHeight(AppSize.s50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(
            AppSize.s8,
          )),
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      subtitle1: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      caption: getRegularStyle(
        color: ColorManager.primary,
      ),
      bodyText1: getRegularStyle(
        color: ColorManager.grey,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p8,
      ),
      hintStyle: getRegularStyle(
        color: ColorManager.primary,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.primary,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.red,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.red,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSize.s8,
          ),
        ),
      ),
    ),
  );
}
