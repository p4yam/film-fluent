import 'package:film_fluent/core/utils/text_themes.dart';
import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final Color borderColor;
  final double size;
  final bool allowHalfRating;
  final IconData filledIconData;
  final IconData halfFilledIconData;
  final IconData defaultIconData;
  final double spacing;
  final int voteAmount;
  StarRating({
    this.starCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    this.voteAmount=0,
    this.defaultIconData,
    this.onRatingChanged,
    this.color,
    this.borderColor,
    this.size = 20,
    this.filledIconData,
    this.halfFilledIconData,
    this.allowHalfRating = true,
  }) {
    assert(this.rating != null);
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        defaultIconData != null ? defaultIconData : Icons.star_border,
        color: borderColor ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else if (index > rating - (allowHalfRating ? 1.0 : 0.5) &&
        index < rating) {
      icon =  Icon(
        halfFilledIconData != null ? halfFilledIconData : Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = Icon(
        filledIconData != null ? filledIconData : Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      )..add(Padding(
        padding: const EdgeInsets.only(left: 4,right: 4),
        child: Text('($voteAmount)',style: TextThemes.blackNormal16,),
      )),
    );
  }
}
