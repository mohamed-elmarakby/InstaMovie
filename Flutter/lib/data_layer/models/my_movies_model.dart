import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MyMoviesModel {
  List<Movies?> movies;
  MyMoviesModel(this.movies);
}

class Movies {
  String? overview;
  String? releaseDate;
  String? title;
  PickedFile? posterPath;

  Movies({
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    overview = json['overview'];
    releaseDate = json['release_date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    return data;
  }
}
