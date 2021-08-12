import 'dart:ui';

import 'package:film_fluent/core/constraints/app_keys.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:film_fluent/feature/movie_list/presentation/manager/movie_list_controller.dart';
import 'package:film_fluent/feature/movie_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:film_fluent/feature/movie_list/presentation/widgets/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieListPageRoute extends StatefulWidget {
  @override
  _MovieListPageRouteState createState() => _MovieListPageRouteState();
}

class _MovieListPageRouteState extends State<MovieListPageRoute> with AutomaticKeepAliveClientMixin{
  var _loadMore = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MovieListController>(
      init: MovieListController(),
      builder: (controller){
        if(controller.state == StateEnum.success)
          _loadMore=false;
        return Scaffold(
          body: _buildBody(controller),
          floatingActionButton: CustomFloatingActionButton(
            height: 300,
            onItemClick: (index){
              controller.sortBy= MovieFilterModel.sampleList[index];
              controller.fetchData(false, true);
            },
            filterList: MovieFilterModel.sampleList,
          ),
        );
      },
    );
  }

  Widget _buildBody(MovieListController controller){
    if (controller.state == StateEnum.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (controller.state == StateEnum.success ||
        controller.state == StateEnum.loadMore) {
      return _movieList(controller);
    } else
      return Container();
  }


  Widget _movieList(MovieListController controller) {
    final results = controller.movieList;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!_loadMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  controller.fetchData(true, false);
                  _loadMore = true;
                  setState(() {});
                }
                return true;
              },
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (_, index) {
                  return MovieListItem(result: results[index],onClick: (){},);
                },
              ),
            ),
          ),
          Container(
            height: _loadMore ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
