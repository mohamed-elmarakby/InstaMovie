import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/my_movies_model.dart';
import 'package:insta_movie_app/data_layer/repositories/movie_repository.dart';
import 'package:insta_movie_app/data_layer/web_services/movie_services.dart';
import 'package:insta_movie_app/service_locator.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> implements MovieInterface {
  BuildContext? context;
  HomeCubit({this.context}) : super(HomeInitial());
  static HomeCubit getCubit(context) => BlocProvider.of<HomeCubit>(context);
  bool isFetching = false;
  MyMoviesModel myMovies = MyMoviesModel([]);
  MovieListModel allMovies = MovieListModel(
    page: 1,
    totalPages: 1,
    totalResults: 0,
    results: [],
  );
  MovieInterface movieInterface = serviceLocator<MovieServices>();

  @override
  Future<Movies> createMovie({
    required String date,
    required String overview,
    required String title,
    required PickedFile? poster,
  }) async {
    try {
      Movies movie = await movieInterface.createMovie(
          date: date, overview: overview, title: title, poster: poster);
      myMovies.movies == null
          ? myMovies.movies = []
          : myMovies.movies.add(movie);
      return movie;
    } catch (e) {
      getCubit(context).emit(HomeError());
      return Movies();
    }
  }

  @override
  Future<MovieListModel> getMovies({int page = 1}) async {
    try {
      allMovies = await movieInterface.getMovies(page: page);
      return allMovies;
    } catch (e) {
      getCubit(context).emit(HomeError());
      return MovieListModel(
          results: [], totalResults: 0, page: 1, totalPages: 1);
    }
  }

  Future<MovieListModel> getMoreMovies({int page = 1}) async {
    try {
      final newMovies = await movieInterface.getMovies(page: page);
      allMovies.page = newMovies.page;
      allMovies.results!.addAll(newMovies.results!);
      allMovies.results = allMovies.results!.toSet().toList();
      return newMovies;
    } catch (e) {
      getCubit(context).emit(HomeError());
      return MovieListModel(
          results: [], totalResults: 0, page: 1, totalPages: 1);
    }
  }
}
