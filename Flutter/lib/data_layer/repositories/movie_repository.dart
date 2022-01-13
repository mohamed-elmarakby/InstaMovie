import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:insta_movie_app/data_layer/models/movie_list_model.dart';
import 'package:insta_movie_app/data_layer/models/my_movies_model.dart';

abstract class MovieInterface {
  Future<MovieListModel> getMovies({int page = 1});
  Future<Movies> createMovie({
    required String date,
    required String overview,
    required String title,
    required PickedFile? poster,
  });
}
