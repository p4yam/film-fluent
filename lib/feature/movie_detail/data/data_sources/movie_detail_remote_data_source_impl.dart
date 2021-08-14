
import 'package:film_fluent/core/utils/api_tools.dart';
import 'package:film_fluent/feature/movie_detail/data/data_sources/movie_detail_remote_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class MovieDetailRemoteDataSourceImpl extends MovieDetailRemoteDataSource{
  final ApiTools apiTools;
  final String baseUrl,apiPath;

  MovieDetailRemoteDataSourceImpl({@required this.apiTools,@required this.baseUrl,@required this.apiPath});

  @override
  Future<Response> fetchMovies(Map<String, dynamic> query, int movieId) async{
    return await apiTools.getRequest(baseUrl, apiPath+'/$movieId', query);
  }

}