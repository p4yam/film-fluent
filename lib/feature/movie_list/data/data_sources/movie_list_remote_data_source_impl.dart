
import 'package:film_fluent/core/utils/api_tools.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class MovieListRemoteDataSourceImpl extends MovieListRemoteDataSource{
  final ApiTools apiTools;
  final String baseUrl,apiPath;
  MovieListRemoteDataSourceImpl({this.apiTools,this.baseUrl, this.apiPath, });

  @override
  Future<Response> fetchMovies(Map<String, dynamic> query) async{
    return await apiTools.getRequest(baseUrl, apiPath, query);
  }

}