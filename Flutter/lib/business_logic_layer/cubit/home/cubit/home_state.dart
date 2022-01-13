part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  HomeLoading({BuildContext? context, int page = 1}) {
    serviceLocator<HomeCubit>().getMovies(page: page).then(
        (value) => serviceLocator<HomeCubit>().emit(HomeLoaded(context!)));
  }
}

class HomeLoaded extends HomeState {
  HomeLoaded(BuildContext context) {
    serviceLocator<HomeCubit>().isFetching = false;
  }
}

class HomeError extends HomeState {
  HomeError();
}

class HomeFetchMore extends HomeState {
  HomeFetchMore({required int page, BuildContext? context}) {
    Future.delayed(Duration(seconds: 2), () async {
      await serviceLocator<HomeCubit>().getMoreMovies(page: page).then((value) {
        serviceLocator<HomeCubit>().allMovies.results!.toSet().toList();
        serviceLocator<HomeCubit>().emit(HomeLoaded(context!));
      });
    });
  }
}
