import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class ArtistAlbumCell extends StatelessWidget {
  final Map aaObj;

  const ArtistAlbumCell({Key? key, required this.aaObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              aaObj["image"],
              width: double.maxFinite,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            aaObj["name"],
            style: TextStyle(
              color: TColor.primaryText60,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
          Text(
            aaObj["year"],
            style: TextStyle(
              color: TColor.primaryText35,
              fontSize: 10,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
