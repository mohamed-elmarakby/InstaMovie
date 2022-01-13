import 'package:insta_movie_app/business_logic_layer/cubit/home/cubit/home_cubit.dart';

import 'data_layer/web_services/movie_services.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupGetIt() {
  serviceLocator.registerSingleton<MovieServices>(MovieServices());
  serviceLocator.registerSingleton<HomeCubit>(HomeCubit());
}
