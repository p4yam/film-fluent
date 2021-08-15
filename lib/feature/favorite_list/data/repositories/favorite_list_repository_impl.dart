
import 'package:dartz/dartz.dart';
import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/models/error_model.dart';
import 'package:film_fluent/feature/favorite_list/data/data_sources/favorite_list_local_data_source.dart';
import 'package:film_fluent/feature/favorite_list/domain/repositories/favorite_list_repository.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';

class FavoriteListRepositoryImpl extends FavoriteListRepository{
  final FavoriteListLocalDataSource localDataSource;

  FavoriteListRepositoryImpl({this.localDataSource});
  @override
  Future<Either<ErrorModel, List<Movie>>> fetchMoviesFromDB() async{
    try{
      final result = await localDataSource.fetchMoviesFromDB();
      if(result!=null)
        return Right(result.toList().map((e) => Movie.fromJson(e)).toList());
      return Left(ErrorModel(message: AppConstraints.NullDataError,id: -1));
    }catch(ex){
      return Left(ErrorModel(message: ex.toString(),id: -1));
    }
  }

}