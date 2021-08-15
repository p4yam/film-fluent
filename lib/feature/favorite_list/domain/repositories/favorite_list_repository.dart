
import 'package:dartz/dartz.dart';
import 'package:film_fluent/core/models/error_model.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';

abstract class FavoriteListRepository{
  Future<Either<ErrorModel,List<Movie>>> fetchMoviesFromDB();
}