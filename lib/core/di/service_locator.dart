import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/utils/api_tools.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source_impl.dart';
import 'package:film_fluent/feature/movie_list/data/repositories/movie_list_repository_impl.dart';
import 'package:film_fluent/feature/movie_list/domain/repositories/movie_list_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => ApiTools());

  // movie_list
  getIt.registerLazySingleton<MovieListRemoteDataSource>(() =>
      MovieListRemoteDataSourceImpl(
          apiTools: getIt(),
          apiPath: AppKeys.DiscoverMoviesPath,
          baseUrl: AppKeys.AppApiUrl));
  getIt.registerFactory<MovieListRepository>(() => MovieListRepositoryImpl(remoteDataSource: getIt()));
}
