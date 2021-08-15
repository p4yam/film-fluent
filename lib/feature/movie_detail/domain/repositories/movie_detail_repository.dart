import 'package:dartz/dartz.dart';
import 'package:film_fluent/core/models/error_model.dart';
import 'package:film_fluent/feature/movie_detail/data/models/movie_detail_model.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';

abstract class MovieDetailRepository {
  Future<Either<ErrorModel, MovieDetailModel>> fetchMovies(
      Map<String, dynamic> query, int movieId);

  Future<Either<ErrorModel,bool>> getMovieFavoriteStatus(int movieId);

  Future<Either<ErrorModel,bool>> addRemoveMovieToDatabase(Movie movieModel);
}
