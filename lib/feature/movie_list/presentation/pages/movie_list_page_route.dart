import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/widgets/error_widget.dart';
import 'package:film_fluent/feature/movie_detail/presentation/pages/movie_detail_page_route.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:film_fluent/feature/movie_list/presentation/manager/movie_list_controller.dart';
import 'package:film_fluent/feature/movie_list/presentation/widgets/custom_floating_action_button.dart';
import 'package:film_fluent/feature/movie_list/presentation/widgets/custom_search_appbar.dart';
import 'package:film_fluent/core/widgets/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieListPageRoute extends StatefulWidget {
  @override
  _MovieListPageRouteState createState() => _MovieListPageRouteState();
}

class _MovieListPageRouteState extends State<MovieListPageRoute>
    with AutomaticKeepAliveClientMixin {
  var _loadMore = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MovieListController>(
      init: MovieListController(),
      builder: (controller) {
        if (controller.state == StateEnum.success) _loadMore = false;
        return Scaffold(
          appBar: CustomSearchAppbar(
            onClearTextClicked: (){
              controller.searchString='';
            },
            onSearchClicked: (searchString) {
              controller.searchString= searchString;
              if (controller.searchString.isNotEmpty)
                controller.fetchData(
                     true, controller.searchString.replaceAll(' ', '%20'));
              else
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppConstraints.EmptySearchQueryError),
                  backgroundColor: AppColor.RedAccent,
                ));
            },
          ),
          body: _buildBody(controller),
          floatingActionButton: (controller.state == StateEnum.success &&
                  controller.movieList.length > 0)
              ? CustomFloatingActionButton(
                  height: 300,
                  onItemClick: (index) {

                    controller.sortMovies(MovieFilterModel.sampleList[index]);
                  },
                  filterList: MovieFilterModel.sampleList,
                )
              : null,
        );
      },
    );
  }

  Widget _buildBody(MovieListController controller) {
    if (controller.state == StateEnum.initial)
      return CustomErrorWidget(
        buttonWidth: Get.width / 3,
        errorMessage: AppConstraints.EmptySearch,
        imagePath: 'assets/images/undraw_searching_p5ux.svg',
        showRefreshButton: false,
        imageWidth: Get.width / 2,
        onRefreshClicked: () {},
      );
    else if (controller.state == StateEnum.loading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (controller.state == StateEnum.success ||
        controller.state == StateEnum.loadMore) {
      return _movieList(controller);
    } else
      return CustomErrorWidget(
        buttonWidth: Get.width / 3,
        errorMessage: controller.errorMessage.toString(),
        imagePath: 'assets/images/undraw_Location_search_re_ttoj.svg',
        showRefreshButton: true,
        imageWidth: Get.width / 2,
        onRefreshClicked: () {
          controller.fetchData(
              true, controller.searchString.replaceAll(' ', '%20'));
        },
      );
  }

  Widget _movieList(MovieListController controller) {
    final results = controller.movieList;
    if(results.length>0)
      return Column(
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!_loadMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                controller.fetchData(
                    false, controller.searchString.replaceAll(' ', '%20'));
                _loadMore = true;
                setState(() {});
              }
              return true;
            },
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, index) {
                return Hero(
                  tag: 's${results[index].id}',
                  child: MovieListItem(
                    result: results[index],
                    onClick: () {
                      Get.to(()=>MovieDetailPageRoute(movieItem: results[index],heroTag: 's${results[index].id}',));
                    },
                  ),
                );
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
    );
    return CustomErrorWidget(
      buttonWidth: Get.width / 3,
      errorMessage: AppConstraints.NothingFound,
      imagePath: 'assets/images/undraw_searching_p5ux.svg',
      showRefreshButton: false,
      imageWidth: Get.width / 2,
      onRefreshClicked: () {},
    );
  }

  @override
  bool get wantKeepAlive => true;
}
