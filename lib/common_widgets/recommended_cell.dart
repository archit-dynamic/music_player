import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class RecommendedCell extends StatelessWidget {
  final Map mObj;

  const RecommendedCell({Key? key, required this.mObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              mObj["image"],
              width: double.maxFinite,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            mObj["name"],
            style: TextStyle(
              color: TColor.primaryText60,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
          Text(
            mObj["artists"],
            style: TextStyle(
              color: TColor.secondaryText,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
