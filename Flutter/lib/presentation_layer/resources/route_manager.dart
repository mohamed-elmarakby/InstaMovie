import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/route_model.dart';
import 'package:insta_movie_app/presentation_layer/resources/color_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/style_manager.dart';
import 'package:insta_movie_app/presentation_layer/resources/value_manager.dart';
import 'package:insta_movie_app/presentation_layer/screens/authentication/login.dart';
import 'package:insta_movie_app/presentation_layer/screens/authentication/register.dart';
import 'package:insta_movie_app/presentation_layer/screens/details/movie_details.dart';
import 'package:insta_movie_app/presentation_layer/screens/details/my_movie_details.dart';
import 'package:insta_movie_app/presentation_layer/screens/home/home.dart';
import 'package:insta_movie_app/presentation_layer/screens/home/my_movies.dart';
import 'package:insta_movie_app/presentation_layer/screens/new_movie/new_movie.dart';
import 'package:insta_movie_app/presentation_layer/screens/splash.dart';
import 'package:insta_movie_app/presentation_layer/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_movie_app/service_locator.dart';
import 'string_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String homePageRoute = '/homePage';
  static const String addNew = '/addNew';
  static const String movieDetails = '/movieDetails';
  static const String myMovieDetails = '/myMovieDetails';
  static const String allMovies = '/allMovies';
  static const String myMovies = '/myMovies';
}

class RouterGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
            builder: (_) => Builder(builder: (_) => const SplashView()));
      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => Builder(builder: (_) => const LoginScreen()));
      case Routes.registerRoute:
        return MaterialPageRoute(
            builder: (_) => Builder(builder: (_) => const RegisterScreen()));
      case Routes.myMovieDetails:
        return MaterialPageRoute(
            builder: (_) => Builder(
                builder: (_) => BlocProvider<HomeCubit>(
                    create: (context) => serviceLocator<HomeCubit>(),
                    child: MyMovieDetailsScreen(
                      args: (routeSettings.arguments as RouteArguments),
                    ))));
      case Routes.homePageRoute:
        log(routeSettings.arguments.toString());
        log(routeSettings.name.toString());

        return MaterialPageRoute(
            builder: (_) => Builder(
                builder: (_) => BlocProvider<HomeCubit>(
                      create: (context) => serviceLocator<HomeCubit>(),
                      child: HomeScreen(
                        cubit: routeSettings.arguments == null
                            ? null
                            : routeSettings.arguments as HomeCubit,
                      ),
                    )));
      case Routes.myMovies:
        log(routeSettings.arguments.toString());

        return MaterialPageRoute(
            builder: (_) => Builder(
                builder: (_) => MyMoviesScreen(
                      cubit: routeSettings.arguments as HomeCubit,
                    )));
      case Routes.addNew:
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (_) => BlocProvider<HomeCubit>(
              create: (context) => serviceLocator<HomeCubit>(),
              child: NewMovieScreen(
                cubit: routeSettings.arguments as HomeCubit,
              ),
            ),
          ),
        );
      case Routes.movieDetails:
        log('name below:');

        log(routeSettings.name.toString());
        log('arguments below:');
        log(routeSettings.arguments.toString());
        log((routeSettings.arguments as RouteArguments).cubit.toString());
        return MaterialPageRoute(
          builder: (_) => Builder(
            builder: (_) => BlocProvider<HomeCubit>(
              create: (context) => serviceLocator<HomeCubit>(),
              child: MovieDetailsScreen(
                args: (routeSettings.arguments as RouteArguments),
              ),
            ),
          ),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: appBarWidget(
          backAllowed: true,
          args: null,
          routeName: Routes.homePageRoute,
        ),
        body: Center(
          child: Text(
            AppStrings.noRouteFound,
            style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: AppSize.s18,
            ),
          ),
        ),
      ),
    );
  }
}
