import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/constraints/state_enum.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:film_fluent/core/widgets/movie_list_item.dart';
import 'package:film_fluent/feature/movie_detail/data/models/movie_detail_model.dart';
import 'package:film_fluent/feature/movie_detail/presentation/manager/movie_detail_controller.dart';
import 'package:film_fluent/feature/movie_detail/presentation/widgets/app_star_rating.dart';
import 'package:film_fluent/feature/movie_detail/presentation/widgets/find_more_widget.dart';
import 'package:film_fluent/feature/movie_detail/presentation/widgets/label_view_widget.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailPageRoute extends StatefulWidget {
  final Movie movieItem;
  final String heroTag;
  MovieDetailPageRoute({Key key,@required this.movieItem, this.heroTag}) : super(key: key);

  @override
  _MovieDetailPageRouteState createState() => _MovieDetailPageRouteState();
}

class _MovieDetailPageRouteState extends State<MovieDetailPageRoute> {
  var _firstTime=true;
  final _movieDetailController = Get.put(MovieDetailController());

  @override
  void initState() {
    _movieDetailController.getMovieFavoriteStatus(widget.movieItem.id??-1);
    super.initState();
  }
  @override
  void dispose() {
    _movieDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailController>(
      init: _movieDetailController,
      builder: (controller) {
        if(controller.state==StateEnum.error)
          _showErrorMessage(controller.errorMessage);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.movieItem.title,
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            actions: [
              IconButton(onPressed: () {
                controller.addRemoveMovieToFavorites(widget.movieItem);
              }, icon: Icon(controller.movieFavoriteStatus?Icons.favorite:Icons.favorite_border))
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (controller.state == StateEnum.success &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent && _firstTime && !controller.movieFavoriteStatus) {
                _firstTime=false;
                _showFavoriteSnackbar(controller);
              }
              return true;
            },
            child: ListView(
              children: [
                Hero(
                  tag: widget.heroTag,
                  child: MovieListItem(
                    onClick: () {},
                    result: widget.movieItem,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: StarRating(
                    color: AppColor.YellowAccent,
                    borderColor: AppColor.YellowAccent,
                    rating: widget.movieItem.voteAverage / 2,
                    voteAmount: widget.movieItem.voteCount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Text(
                    widget.movieItem.overview,
                    style: TextThemes.blackNormal16,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: _buildGenre(),
                ),
                FindMoreWidget(
                  onClick: () {
                    if (controller.state != StateEnum.success)
                      controller.fetchData(widget.movieItem.id);
                  },
                  isLoading: controller.state == StateEnum.loading,
                ),
                if (controller.state == StateEnum.success)
                  _buildMoreInfo(controller.movieDetailModel)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGenre() {
    var genres = AppConstraints.MovieGenre.where((element) => widget
        .movieItem.genreIds
        .any((genreId) => genreId == element['id'])).toList();
    return Wrap(
        children: List.generate(
            genres.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.GrayLight,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                        child: Text(
                          genres[index]['name'],
                          style: TextThemes.blackNormal16,
                        ),
                      )),
                )));
  }

  void _showErrorMessage(String message){
    WidgetsBinding.instance.addPostFrameCallback((_){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: AppColor.RedAccent,));
    });

  }

  void _showFavoriteSnackbar(MovieDetailController controller){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
      children: [
        Text('Add this movie to favorites?'),
        Spacer(),
        TextButton(onPressed: (){
          controller.addRemoveMovieToFavorites(widget.movieItem);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }, child: Text('Yes'))
      ],
    ),backgroundColor: AppColor.Green,),);
  }

  Widget _buildMoreInfo(MovieDetailModel model) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelViewWidget(
              labelName: AppConstraints.Title,
              labelDetail: model.title ?? '-',
              iconData: Icons.title,
            ),
            LabelViewWidget(
              labelName: AppConstraints.TagLine,
              labelDetail: model.tagline ?? '-',
              iconData: Icons.sort,
            ),
            LabelViewWidget(
              labelName: AppConstraints.StatusLabel,
              labelDetail: model.status ?? '-',
              iconData: Icons.build,
            ),
            LabelViewWidget(
              labelName: AppConstraints.ReleaseDateLabel,
              labelDetail: model.releaseDate ?? '-',
              iconData: Icons.access_time_rounded,
            ),
            LabelViewWidget(
              labelName: AppConstraints.ImdbId,
              labelDetail: model.imdbId ?? '-',
              iconData: Icons.info_outline_rounded,
            ),
            LabelViewWidget(
              labelName: AppConstraints.ProductionCountries,
              labelDetail:
                  model.productionCountries.map((e) => e.name).join(', '),
              iconData: Icons.account_balance_wallet_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
