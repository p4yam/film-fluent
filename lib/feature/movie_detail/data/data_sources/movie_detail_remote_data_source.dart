
import 'package:get/get_connect/http/src/response/response.dart';

abstract class MovieDetailRemoteDataSource{

  Future<Response> fetchMovies(Map<String,dynamic> query, int movieId);
}