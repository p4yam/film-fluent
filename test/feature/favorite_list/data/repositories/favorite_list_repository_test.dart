import 'package:dartz/dartz.dart';
import 'package:film_fluent/feature/favorite_list/data/data_sources/favorite_list_local_data_source.dart';
import 'package:film_fluent/feature/favorite_list/data/repositories/favorite_list_repository_impl.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_list_repository_test.mocks.dart';

@GenerateMocks([FavoriteListLocalDataSource])
main() {
  group('favorite_list domain', () {
    final mockLocalDatasource = MockFavoriteListLocalDataSource();
    final sut =
        FavoriteListRepositoryImpl(localDataSource: mockLocalDatasource);

    test('should return Right(List) if fetching data from db is a success',
        () async {
      when(mockLocalDatasource.fetchMoviesFromDB())
          .thenAnswer((realInvocation) async => <Movie>[]);

      final result = await sut.fetchMoviesFromDB();

      expect(result, isA<Right>());
    });

    test('should return Left(ErrorModel) if fetching data from db is a failure',
            () async {
          when(mockLocalDatasource.fetchMoviesFromDB())
              .thenThrow(Exception('message'));

          final result = await sut.fetchMoviesFromDB();

          expect(result, isA<Left>());
        });

    test('should return Left(ErrorModel) if fetching data from db is null',
            () async {
          when(mockLocalDatasource.fetchMoviesFromDB())
              .thenAnswer((realInvocation) async=> null);

          final result = await sut.fetchMoviesFromDB();

          expect(result, isA<Left>());
        });
  });
}
