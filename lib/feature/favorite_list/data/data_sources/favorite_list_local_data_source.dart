
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';

abstract class FavoriteListLocalDataSource{

  Future<Iterable<dynamic>> fetchMoviesFromDB();
}