import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/route_model.dart';
import 'package:insta_movie_app/data_layer/repositories/movie_repository.dart';
import 'package:insta_movie_app/data_layer/web_services/movie_services.dart';
import 'package:insta_movie_app/presentation_layer/resources/assets_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/route_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';
import 'package:insta_movie_app/presentation_layer/widgets/appbar.dart';
import 'package:insta_movie_app/presentation_layer/widgets/insta_button.dart';

class MovieDetailsScreen extends StatefulWidget {
  final RouteArguments? args;
  const MovieDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.args!.cubit!.isFetching = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
          context,
          widget.args!.route!,
          arguments: widget.args!.cubit,
        );
        return true;
      },
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          backAllowed: true,
          routeName: widget.args!.route,
          args: widget.args!.cubit,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsetsDirectional.all(AppSize.s8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: AppSize.s12),
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  AppSize.s10,
                                ),
                              ),
                            ),
                            child: FadeInImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                '${AppStrings.imagesUrl}${widget.args!.movie!.posterPath}',
                              ),
                              placeholder:
                                  AssetImage(AssetsManager.pictureLoading),
                            ),
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
                          ListTile(
                            title: Text(
                              '${widget.args!.movie!.title}',
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
                                    '${widget.args!.movie!.releaseDate}',
                                    style: getMediumStyle(
                                      color: ColorManager.whiteWithOpacity60,
                                      fontSize: AppSize.s12,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.args!.movie!.overview}',
                                  style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: AppSize.s14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
