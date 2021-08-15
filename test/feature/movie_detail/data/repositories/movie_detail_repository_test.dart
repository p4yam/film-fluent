import 'package:dartz/dartz.dart';
import 'package:film_fluent/core/models/error_model.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_local_data_source.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_remote_data_source_impl.dart';
import 'package:film_fluent/feature/movie_detail/data/repositories/movie_detail_repository_impl.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_repository_test.mocks.dart';

@GenerateMocks([MovieDetailRemoteDataSourceImpl, MovieDetailLocalDataSource])
void main() {
  group('movie_detail domain', () {
    final mockRemoteDataSource = MockMovieDetailRemoteDataSourceImpl();
    final mockLocalDatasource = MockMovieDetailLocalDataSource();
    final sut = MovieDetailRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDatasource);

    test('returns Right side if it can fetch movie detail from server',
        () async {
      //Arrange
      final sampleMovieId = 34544;
      final samplePopularity = 22.759;
      when(mockRemoteDataSource.fetchMovies(any, sampleMovieId))
          .thenAnswer((realInvocation) async => Response(body: {
                "id": sampleMovieId,
                "imdb_id": "tt0429493",
                "genres": [],
                "popularity": samplePopularity,
                "production_companies": []
              }));

      //Act
      final result = await sut.fetchMovies({}, sampleMovieId);
      var popularity = -1.0;
      result.fold((l) => null, (r) => popularity = r.popularity);

      //Assert
      expect(result, isA<Right>());
      expect(popularity, samplePopularity);
    });

    test('returns Left side if an error occurs while fetching movies from server', () async {
      //Arrange
      final sampleErrorMessage = 'Http error';
      when(mockRemoteDataSource.fetchMovies(any, any))
          .thenThrow(GetHttpException(sampleErrorMessage));

      //Act
      final result = await sut.fetchMovies({}, 1);
      var errorMessage = '';
      var errorId = 0;
      result.fold((l) {
        errorMessage = l.message;
        errorId = l.id;
      }, (r) => null);
      //Assert
      expect(result, isA<Left>());
      expect(errorMessage, sampleErrorMessage);
      expect(errorId, -1);
    });

    test('returns Right(true)/Right(false) as movie favorite status',()async {
      when(mockLocalDatasource.getMovieFavoriteStatus(0)).thenAnswer((realInvocation) async=> true);
      when(mockLocalDatasource.getMovieFavoriteStatus(1)).thenAnswer((realInvocation) async=> false);

      final fav =await sut.getMovieFavoriteStatus(0);
      final notFav =await sut.getMovieFavoriteStatus(1);
      var favResult;
      var notFavResult;
      fav.fold((l) => null, (r) => favResult=r);
      notFav.fold((l) => null, (r) => notFavResult=r);

      expect(fav,isA<Right>());
      expect(notFav,isA<Right>());
      expect(favResult,true);
      expect(notFavResult,false);
    });

    test('returns Right(true)/Right(false) for adding/removing movie to database',()async {
      when(mockLocalDatasource.addRemoveMovieToDatabase(any)).thenAnswer((realInvocation) async=> true);

      final fav =await sut.addRemoveMovieToDatabase(Movie(id: 0));

      expect(fav,isA<Right>());
    });

    test('returns Left(ErrorModel) if an error occurs while adding/removing movie to database',()async {
      when(mockLocalDatasource.addRemoveMovieToDatabase(any)).thenThrow(Exception('error'));

      final fav =await sut.addRemoveMovieToDatabase(Movie(id: 0));
      var error;
      fav.fold((l) => error=l, (r) => null);
      expect(fav,isA<Left>());
      expect(error,isA<ErrorModel>());
    });

    test('returns Right(false) if an error occurs white getting movie favorite status',()async {
      when(mockLocalDatasource.getMovieFavoriteStatus(0)).thenThrow(Exception('error message'));

      final fav =await sut.getMovieFavoriteStatus(0);
      var favResult;
      fav.fold((l) => null, (r) => favResult=r);

      expect(fav,isA<Right>());
      expect(favResult,false);
    });

  });
}
