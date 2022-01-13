import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';
import '../resources/color_manager.dart';
import 'package:flutter/material.dart';

AppBar appBarWidget({
  backAllowed = false,
  List<Widget>? actions,
  BuildContext? context,
  HomeCubit? args,
  var routeName,
}) {
  return AppBar(
    centerTitle: true,
    leading: backAllowed
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorManager.primary,
            onPressed: () => Navigator.pushReplacementNamed(
              context!,
              routeName,
              arguments: args == null ? null : args as HomeCubit,
            ),
          )
        : null,
    title: Text(
      AppStrings.englishAppName,
      style: getBoldStyle(
        color: ColorManager.primary,
        fontSize: AppSize.s16,
      ),
    ),
  );
}
