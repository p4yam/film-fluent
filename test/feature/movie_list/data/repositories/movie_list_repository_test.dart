import 'package:dartz/dartz.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source_impl.dart';
import 'package:film_fluent/feature/movie_list/data/repositories/movie_list_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_repository_test.mocks.dart';

@GenerateMocks([MovieListRemoteDataSourceImpl])
void main() {
  group('movie_list domain', () {
    /// Either keyword would return [Right(Answer)] if the operation is a success
    test('returns Right side if search operation is a succcess', () async {
      //Arrange
      final mockDataSource = MockMovieListRemoteDataSourceImpl();
      final sut = MovieListRepositoryImpl(remoteDataSource: mockDataSource);
      final sampleTotalPages = 500; // Based on the sample query
      final sampleId = 436969;
      when(mockDataSource.fetchMovies({})).thenAnswer((realInvocation) async =>
          Response(body: {
            'total_pages': 500,
            'total_results': 10000,
            'results': [
              {"id": 436969,}
            ],
            'page': 1
          }));

      //Act
      final result = await sut.fetchMovies({});
      var totalPages = 0;
      var movieId =0;
      result.fold((l) => null, (r) {
        totalPages = r.totalPages;
        movieId = r.results[0].id;
      });
      //Assert
      expect(result, isA<Right>());
      expect(totalPages, sampleTotalPages);
      expect(movieId, sampleId);
    });

    /// Either keyword would return [Left(ErrorModel)] if the operation is a Failure
    test('returns Left side if search is a failure', () async {
      //Arrange
      final mockDataSource = MockMovieListRemoteDataSourceImpl();
      final sut = MovieListRepositoryImpl(remoteDataSource: mockDataSource);
      final sampleErrorMessage = 'Http error';
      when(mockDataSource.fetchMovies({})).thenThrow(GetHttpException(sampleErrorMessage));

      //Act
      final result = await sut.fetchMovies({});
      var errorMessage = '';
      var errorId = 0;
      result.fold((l) {
        errorMessage =l.message;
        errorId = l.id;
      }, (r)=> null);
      //Assert
      expect(result, isA<Left>());
      expect(errorMessage, sampleErrorMessage);
      expect(errorId, -1); // default error id is -1
    });
  });
}
