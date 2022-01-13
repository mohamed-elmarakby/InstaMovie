import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/my_movies_model.dart';

class RouteArguments {
  final String? route;
  final Results? movie;
  final Movies? myMovie;
  final HomeState? state;
  final HomeCubit? cubit;

  RouteArguments({
    this.route,
    this.movie,
    this.myMovie,
    this.cubit,
    this.state,
  });
}
