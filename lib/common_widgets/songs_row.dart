import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class SongsRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;
  final VoidCallback onPressedPlay;

  const SongsRow({
    Key? key,
    required this.sObj,
    required this.onPressed,
    required this.onPressedPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onPressedPlay,
              icon: Image.asset(
                AppImages.playBtn,
                width: 25,
                height: 25,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sObj["name"],
                    style: TextStyle(
                      color: TColor.primaryText60,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    sObj["artists"],
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset(
                  AppImages.fav,
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  height: 4,
                ),
                IgnorePointer(
                  ignoring: true,
                  child: RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    unratedColor: TColor.org.withOpacity(0.2),
                    itemCount: 5,
                    itemSize: 12,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: TColor.org,
                    ),
                    updateOnDrag: false,
                    onRatingUpdate: (rating) {
                      debugPrint("$rating");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.white.withOpacity(0.07),
          indent: 50,
        ),
      ],
    );
  }
}
