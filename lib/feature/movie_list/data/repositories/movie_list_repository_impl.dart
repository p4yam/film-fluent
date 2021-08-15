
import 'package:dartz/dartz.dart';
import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/models/error_model.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:film_fluent/feature/movie_list/domain/repositories/movie_list_repository.dart';

class MovieListRepositoryImpl extends MovieListRepository{

  final MovieListRemoteDataSource remoteDataSource;
  MovieListRepositoryImpl( { this.remoteDataSource});

  @override
  Future<Either<ErrorModel, MovieListModel>> fetchMovies(Map<String,dynamic> query) async{
    try{
      final req = await remoteDataSource.fetchMovies(query);
      if(req!=null)
        return Right(MovieListModel.fromJson(req.body));
      return Left(ErrorModel(message: AppConstraints.NullDataError,id: -1));
    }catch(ex){
      return Left(ErrorModel(message:ex.toString(),id: -1));
    }
  }

}