import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/feature/favorite_list/presentation/pages/favorite_list_page_route.dart';
import 'package:flutter/material.dart';

import 'movie_list/presentation/pages/movie_list_page_route.dart';

class HomePageRoute extends StatefulWidget {
  const HomePageRoute({Key key}) : super(key: key);

  @override
  _HomePageRouteState createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
  final _pageController = PageController();
  var _currentPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MovieListPageRoute(),
         FavoriteListPageRoute()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          _pageController.jumpToPage(index);
          setState(() {
            _currentPage=index;
          });
        },
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search),label: AppConstraints.NavBarSearch),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: AppConstraints.NavBarFavorite),
        ],
      ),
    );
  }
}