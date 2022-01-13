import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/my_movies_model.dart';
import 'package:insta_movie_app/data_layer/repositories/movie_repository.dart';

import '../../presentation_layer/resources/string_manager.dart';
import 'package:dio/dio.dart';

class MovieServices implements MovieInterface {
  late Dio dio;
  MovieServices() {
    BaseOptions options = BaseOptions(
      baseUrl: AppStrings.baseUrl,
      headers: {
        'Accept': 'application/json',
      },
      receiveDataWhenStatusError: true,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );

    dio = Dio(options);
  }

  @override
  Future<Movies> createMovie({
    required String date,
    required String overview,
    required String title,
    required PickedFile? poster,
  }) async {
    return Movies(
      overview: overview,
      title: title,
      releaseDate: date,
      posterPath: poster,
    );
  }

  @override
  Future<MovieListModel> getMovies({int page = 1}) async {
    try {
      log(dio.options.baseUrl);
      Response response = await dio.get(
          'https://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=$page',
          queryParameters: {
            'api_key': AppStrings.apiKey,
            'page': page,
          });
      return MovieListModel.fromJson(response.data);
    } catch (e) {
      log(e.toString());
      return MovieListModel(
        results: [],
        page: page,
      );
    }
  }

  @override
  Future<Results> addToMyMovies({required Results movie}) async {
    return movie;
  }
}
