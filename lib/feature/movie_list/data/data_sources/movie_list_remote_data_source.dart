
import 'package:get/get.dart';

abstract class MovieListRemoteDataSource{

  Future<Response> fetchMovies(Map<String,dynamic> query);
}