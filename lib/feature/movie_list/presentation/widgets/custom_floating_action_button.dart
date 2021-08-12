import 'package:film_fluent/core/constraints/app_constraints.dart';
import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:film_fluent/feature/movie_list/data/models/movie_filter_model.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function(int) onItemClick;
  final double height;
  final List<MovieFilterModel> filterList;
  const CustomFloatingActionButton({Key key, this.onItemClick, this.height, this.filterList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_alt_outlined),
      onPressed: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (_) {
              return Container(
                height: height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppConstraints.SearchBottomSheetHeader,style: TextThemes.blackNormal19,),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filterList.length,
                        itemBuilder: (_,index){
                          return InkWell(
                            onTap:(){
                              onItemClick(index);
                              Navigator.pop(context);
                            },
                            child: Container(
                              color: index%2==0?AppColor.White:AppColor.GrayLighter,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(filterList[index].name,style: TextThemes.blackNormal16,),
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
