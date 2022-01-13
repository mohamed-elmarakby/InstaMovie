import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/route_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';
import 'package:insta_movie_app/presentation_layer/screens/home/home.dart';
import 'package:insta_movie_app/presentation_layer/widgets/appbar.dart';
import 'package:insta_movie_app/presentation_layer/widgets/insta_button.dart';
import 'package:insta_movie_app/presentation_layer/widgets/movie.dart';
import 'package:insta_movie_app/presentation_layer/widgets/my_movie.dart';

class MyMoviesScreen extends StatefulWidget {
  HomeCubit? cubit;
  MyMoviesScreen({Key? key, this.cubit}) : super(key: key);

  @override
  _MyMoviesScreenState createState() => _MyMoviesScreenState();
}

class _MyMoviesScreenState extends State<MyMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          Routes.homePageRoute,
          arguments: widget.cubit,
        );
        return true;
      },
      child: Scaffold(
        appBar: appBarWidget(
          backAllowed: true,
          context: context,
          routeName: Routes.homePageRoute,
          args: widget.cubit,
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.all(AppSize.s8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(bottom: AppSize.s12),
                  child: Text(
                    AppStrings.myMovies,
                    style: getBoldStyle(
                      color: ColorManager.grey,
                      fontSize: AppSize.s14,
                    ),
                  ),
                ),
                widget.cubit!.myMovies.movies.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: AppSize.s8,
                          ),
                          child: Text(
                            AppStrings.dontHaveMovies,
                            style: getBoldStyle(
                              color: ColorManager.primaryWithOpacity40,
                              fontSize: AppSize.s16,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppSize.s20,
                      end: AppSize.s20,
                    ),
                    child: InstaButton(
                        loading: false,
                        title: AppStrings.addOne,
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: AppSize.s16,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.addNew,
                            arguments: widget.cubit,
                          );
                        }),
                  ),
                ),
                ...widget.cubit!.myMovies.movies
                    .map(
                      (movie) => MyMovieWidget(
                        movie: movie!,
                        from: Routes.myMovies,
                        cubit: widget.cubit!,
                        clickable: true,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
