import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/route_model.dart';
import 'package:insta_movie_app/presentation_layer/resources/assets_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/route_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';

class MovieWidget extends StatelessWidget {
  final bool clickable;
  final bool isHorizontal;
  final Results movie;
  final String? from;
  final HomeCubit cubit;
  const MovieWidget({
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
          log(RouteArguments(
            route: from,
            movie: movie,
            cubit: cubit,
          ).cubit.toString());
          log('cubit above');
          Navigator.pushReplacementNamed(
            context,
            Routes.movieDetails,
            arguments: RouteArguments(
              route: from,
              movie: movie,
              cubit: cubit,
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
                  child: FadeInImage(
                    image: NetworkImage(
                      '${AppStrings.imagesUrl}${movie.posterPath}',
                    ),
                    placeholder: const AssetImage(AssetsManager.pictureLoading),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppSize.s8,
                      end: AppSize.s8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${movie.originalTitle}',
                          style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: AppSize.s14,
                          ),
                        ),
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
                          '${movie.adult! ? 'Adults Only' : 'Family Movie'}',
                          style: getMediumStyle(
                            color: ColorManager.whiteWithOpacity60,
                            fontSize: AppSize.s14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Language: ${movie.originalLanguage!.toUpperCase()}',
                            style: getMediumStyle(
                              color: ColorManager.whiteWithOpacity60,
                              fontSize: AppSize.s14,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: AppSize.s4,
                              ),
                              child: Icon(
                                Icons.star,
                                color: ColorManager.primary,
                                size: AppSize.s14,
                              ),
                            ),
                            Text(
                              '${movie.voteAverage}',
                              style: getMediumStyle(
                                color: ColorManager.whiteWithOpacity60,
                                fontSize: AppSize.s14,
                              ),
                            ),
                          ],
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
