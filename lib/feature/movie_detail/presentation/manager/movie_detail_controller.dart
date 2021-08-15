import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/feature/movie_detail/data/models/movie_detail_model.dart';
import 'package:film_fluent/feature/movie_detail/domain/repositories/movie_detail_repository.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:get/get.dart';
import 'package:film_fluent/core/di/service_locator.dart' as di;


class MovieDetailController extends GetxController {
  /// injecting dependencies instead of creating multiple new items
  /// GetX dependency injection has some problems with [PageView]
  /// so I used [get_it] package alongside
  final repository = di.getIt<MovieDetailRepository>();
  var _errorMessage = '';
  var movieFavoriteStatus=false;
  String get errorMessage => _errorMessage;
  MovieDetailModel _movieDetailModel;
  MovieDetailModel get movieDetailModel => _movieDetailModel;
  var state = StateEnum.initial;

  void fetchData(int movieId) async {
    state = StateEnum.loading;
    update();
    final result = await repository.fetchMovies({
      'api_key': AppKeys.ApiKey,
    }, movieId);
    result.fold((l) {
      state = StateEnum.error;
      _errorMessage = l.message;
    }, (r) {
      state = StateEnum.success;
      _movieDetailModel = r;
    });
    update();
  }

  void getMovieFavoriteStatus(int movieId)async{
    final result =await repository.getMovieFavoriteStatus(movieId);
    result.fold((l) => movieFavoriteStatus=false, (r) => movieFavoriteStatus=r);
    update();

  }

  void addRemoveMovieToFavorites(Movie movie)async{
    final result = await repository.addRemoveMovieToDatabase(movie);
    result.fold((l) {
      state = StateEnum.error;
      _errorMessage = l.message;
    }, (r) {
      movieFavoriteStatus=r;
    });
    update();
  }
}
