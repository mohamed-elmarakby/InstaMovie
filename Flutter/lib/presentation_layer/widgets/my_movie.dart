import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/my_movies_model.dart';
import 'package:insta_movie_app/data_layer/models/route_model.dart';
import 'package:insta_movie_app/presentation_layer/resources/assets_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/route_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';

class MyMovieWidget extends StatelessWidget {
  final bool clickable;
  final bool isHorizontal;
  final Movies movie;
  final String? from;
  final HomeCubit cubit;
  const MyMovieWidget({
    required this.movie,
    required this.cubit,
    this.from,
    this.isHorizontal = false,
    this.clickable = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSize.s12),
      child: GestureDetector(
        onTap: () {
          log('cubit above');
          Navigator.pushReplacementNamed(
            context,
            Routes.myMovieDetails,
            arguments: RouteArguments(
              cubit: cubit,
              route: from,
              myMovie: movie,
            ),
          );
        },
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.file(
                    File(movie.posterPath!.path),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListTile(
                    title: Text(
                      '${movie.title}',
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: AppSize.s14,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: AppSize.s4,
                            bottom: AppSize.s4,
                          ),
                          child: Text(
                            '${movie.releaseDate}',
                            style: getMediumStyle(
                              color: ColorManager.whiteWithOpacity60,
                              fontSize: AppSize.s12,
                            ),
                          ),
                        ),
                        Text(
                          '${movie.overview}',
                          style: getRegularStyle(
                            color: ColorManager.grey,
                            fontSize: AppSize.s14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: AppSize.s12,
                bottom: AppSize.s12,
                start: AppSize.s12,
                end: AppSize.s12,
              ),
              child: Divider(
                color: ColorManager.greyWithOpacity80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
