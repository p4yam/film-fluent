
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';

abstract class MovieDetailLocalDataSource{
  Future<bool> addRemoveMovieToDatabase(Movie movieModel);

  Future<bool> getMovieFavoriteStatus(int movieId);
}