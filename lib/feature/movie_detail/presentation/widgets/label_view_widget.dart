import 'package:film_fluent/core/utils/app_colors.dart';
import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:flutter/material.dart';

class LabelViewWidget extends StatelessWidget {
  final String labelName,labelDetail;
  final IconData iconData;

  const LabelViewWidget({Key key, this.labelName, this.labelDetail, this.iconData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData,color: AppColor.Green,size: 18,),
              Padding(
                padding: const EdgeInsets.only(left: 4,right: 4),
                child: Text(labelName,style: TextThemes.blackNormal16,),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: Text(labelDetail,style: TextThemes.blackNormal17,),
          ),

        ],
      ),
    );
  }
}
