import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/utils/api_tools.dart';
import 'package:film_fluent/feature/favorite_list/data/data_sources/favorite_list_local_data_source.dart';
import 'package:film_fluent/feature/favorite_list/data/data_sources/favorite_list_local_data_source_impl.dart';
import 'package:film_fluent/feature/favorite_list/data/repositories/favorite_list_repository_impl.dart';
import 'package:film_fluent/feature/favorite_list/domain/repositories/favorite_list_repository.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_local_data_source.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_local_data_source_impl.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_remote_data_source.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_remote_data_source_impl.dart';
import 'package:film_fluent/feature/movie_detail/data/repositories/movie_detail_repository_impl.dart';
import 'package:film_fluent/feature/movie_detail/domain/repositories/movie_detail_repository.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source_impl.dart';
import 'package:film_fluent/feature/movie_list/data/repositories/movie_list_repository_impl.dart';
import 'package:film_fluent/feature/movie_list/domain/repositories/movie_list_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => ApiTools());

  /// Injecting [ApiTools], [MovieListRemoteDataSource] and
  /// [MovieListRepository] for movie_list
  getIt.registerLazySingleton<MovieListRemoteDataSource>(() =>
      MovieListRemoteDataSourceImpl(
          apiTools: getIt(),
          apiPath: AppKeys.DiscoverMoviesPath,
          baseUrl: AppKeys.AppApiUrl));
  getIt.registerFactory<MovieListRepository>(
      () => MovieListRepositoryImpl(remoteDataSource: getIt()));

  // injection for movie_detail
  getIt.registerLazySingleton<MovieDetailRemoteDataSource>(() =>
      MovieDetailRemoteDataSourceImpl(
          apiTools: getIt(),
          apiPath: AppKeys.MovieDetailPath,
          baseUrl: AppKeys.AppApiUrl));
  getIt.registerLazySingleton<MovieDetailLocalDataSource>(
      () => MovieDetailLocalDataSourceImpl());
  getIt.registerFactory<MovieDetailRepository>(() => MovieDetailRepositoryImpl(
      remoteDataSource: getIt(), localDataSource: getIt()));


  //injection for favorite_list
  getIt.registerLazySingleton<FavoriteListLocalDataSource>(
      () => FavoriteListLocalDataSourceImpl());
  getIt.registerFactory<FavoriteListRepository>(
      () => FavoriteListRepositoryImpl(localDataSource: getIt()));
}
