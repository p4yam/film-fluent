import 'package:dartz/dartz.dart';
import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/models/error_model.dart';
import 'package:film_fluent/core/widgets/error_widget.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_local_data_source.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_remote_data_source.dart';
import 'package:film_fluent/feature/movie_detail/data/models/movie_detail_model.dart';
import 'package:film_fluent/feature/movie_detail/domain/repositories/movie_detail_repository.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetailRepositoryImpl extends MovieDetailRepository {
  final MovieDetailRemoteDataSource remoteDataSource;
  final MovieDetailLocalDataSource localDataSource;

  MovieDetailRepositoryImpl(
      {@required this.localDataSource, @required this.remoteDataSource});

  @override
  Future<Either<ErrorModel, MovieDetailModel>> fetchMovies(
      Map<String, dynamic> query, int movieId) async {
    try {
      final result = await remoteDataSource.fetchMovies(query, movieId);
      if(result!=null)
        return Right(MovieDetailModel.fromJson(result.body));
      return Left(ErrorModel(message: AppConstraints.NullDataError,id: -1));
    } catch (ex) {
      return Left(ErrorModel(message: ex.toString(), id: -1));
    }
  }

  /// In case of error, returning a default value and keeping the [MovieDetailPageRoute]
  /// clean from [SnackBar] or [CustomErrorWidget].
  @override
  Future<Either<ErrorModel, bool>> getMovieFavoriteStatus(int movieId) async {
    try {
      final result = await localDataSource.getMovieFavoriteStatus(movieId);
      if(result!=null)
        return Right(result);
      return Right(false);
    } catch (ex) {
      return Right(false);
    }
  }

  @override
  Future<Either<ErrorModel, bool>> addRemoveMovieToDatabase(
      Movie movieModel) async {
    try {
      final result = await localDataSource.addRemoveMovieToDatabase(movieModel);
      if(result!=null)
        return Right(result);
      return Left(ErrorModel(message: AppConstraints.ErrorFavoriteAdd,id: -1));
    } catch (ex) {
      return Left(ErrorModel(message: ex.toString()));
    }
  }
}
