import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/route_model.dart';
import 'package:insta_movie_app/data_layer/repositories/movie_repository.dart';
import 'package:insta_movie_app/data_layer/web_services/movie_services.dart';
import 'package:insta_movie_app/presentation_layer/resources/assets_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/string_manager.dart';
import 'package:insta_movie_app/presentation_layer/screens/home/my_movies.dart';
import 'package:insta_movie_app/presentation_layer/widgets/insta_button.dart';
import 'package:insta_movie_app/presentation_layer/widgets/movie.dart';
import '../../resources/color_manager.dart';
import '../../resources/route_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeCubit? cubit;
  HomeScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = ScrollController();
  final _horizontalController = ScrollController();
  @override
  void initState() {
    super.initState();
    log(widget.cubit.toString());
    widget.cubit == null
        ? BlocProvider.of<HomeCubit>(context).emit(HomeInitial())
        // : null
        : BlocProvider.of<HomeCubit>(context).emit(HomeInitial());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: appBarWidget(
            backAllowed: false,
            context: context,
            routeName: Routes.loginRoute,
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              HomeCubit cubit = widget.cubit ?? HomeCubit.getCubit(context);
              log(cubit.hashCode.toString());
              log(widget.cubit == null
                  ? 'null'
                  : widget.cubit.hashCode.toString());
              if (state is HomeInitial) {
                if (widget.cubit == null) {
                  cubit.emit(HomeLoading(context: context, page: 1));
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            bottom: AppSize.s12),
                        child: SpinKitWave(
                          color: ColorManager.primary,
                          size: 34,
                        ),
                      ),
                      Text(
                        AppStrings.loadingMovies,
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: AppSize.s20,
                        ),
                      ),
                    ],
                  );
                }
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    if (cubit.isFetching) {
                      log(cubit.isFetching.toString());
                      log(state.toString());
                      return true;
                    }
                    cubit.isFetching = true;
                    if (state is HomeLoaded) {
                      if (cubit.allMovies.page != cubit.allMovies.totalPages) {
                        log('fetching');
                        cubit.emit(
                          HomeFetchMore(
                            context: context,
                            page: cubit.allMovies.page! + 1,
                          ),
                        );
                      }
                    }
                  }
                  // log(notification.dragDetails == null ? 'end' : 'drag');
                  return true;
                },
                child: ListView(
                  controller: _controller,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.all(AppSize.s8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.myMovies,
                            style: getBoldStyle(
                              color: ColorManager.grey,
                              fontSize: AppSize.s14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.myMovies,
                                arguments: cubit,
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.seeAll,
                                  style: getBoldStyle(
                                    color: ColorManager.grey,
                                    fontSize: AppSize.s14,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorManager.grey,
                                  size: AppSize.s14,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    cubit.myMovies.movies.isEmpty
                        ? Column(
                            children: [
                              Padding(
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
                                          arguments: cubit,
                                        );
                                      }),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _horizontalController,
                              child: Row(
                                  children: cubit.myMovies.movies
                                      .map(
                                        (movie) => GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              Routes.myMovieDetails,
                                              arguments: RouteArguments(
                                                route: Routes.homePageRoute,
                                                myMovie: movie,
                                                cubit: cubit,
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.all(
                                              AppSize.s12,
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          AppSize.s10,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Image.file(
                                                      File(movie!
                                                          .posterPath!.path),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(
                                                      top: AppSize.s8,
                                                      bottom: AppSize.s12,
                                                    ),
                                                    child: Text(
                                                      '${movie.title}',
                                                      style: getBoldStyle(
                                                        color: ColorManager
                                                            .primary,
                                                        fontSize: AppSize.s14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsetsDirectional.all(AppSize.s8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
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
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                bottom: AppSize.s12),
                            child: Text(
                              AppStrings.allMovies,
                              style: getBoldStyle(
                                color: ColorManager.grey,
                                fontSize: AppSize.s14,
                              ),
                            ),
                          ),
                          cubit.allMovies.results!.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      top: AppSize.s8,
                                    ),
                                    child: Text(
                                      AppStrings.dontHaveMovies,
                                      style: getBoldStyle(
                                        color:
                                            ColorManager.primaryWithOpacity40,
                                        fontSize: AppSize.s16,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          ...cubit.allMovies.results!
                              .map((movie) => MovieWidget(
                                    movie: movie,
                                    clickable: true,
                                    cubit: cubit,
                                    from: Routes.homePageRoute,
                                  ))
                              .toList(),
                          if (state is HomeFetchMore)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: AppSize.s10, bottom: AppSize.s40),
                              child: Center(
                                child: SpinKitWave(
                                  color: ColorManager.primaryWithOpacity40,
                                  size: AppSize.s28,
                                ),
                              ),
                            ),
                          if (cubit.allMovies.page ==
                              cubit.allMovies.totalPages)
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 40),
                              child: Center(
                                child: Text(AppStrings.fetchedAll,
                                    style: getBoldStyle(
                                      color: ColorManager.primary,
                                      fontSize: AppSize.s18,
                                    )),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
