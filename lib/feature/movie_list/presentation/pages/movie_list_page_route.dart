import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/utils/api_tools.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:film_fluent/feature/movie_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class MovieListPageRoute extends StatefulWidget {
  @override
  _MovieListPageRouteState createState() => _MovieListPageRouteState();
}

class _MovieListPageRouteState extends State<MovieListPageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        height: 300,
        onItemClick: (index) async{
          final result = await ApiTools().getRequest(AppKeys.AppApiUrl, '/discover/movie', {'api_key':AppKeys.ApiKey});
          print(result.bodyString);
        },
        filterList: MovieFilterModel.sampleList,
      ),
    );
  }
}
