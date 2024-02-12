import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class AlbumSongsRow extends StatelessWidget {
  final Map aObj;
  final VoidCallback onPressed;
  final VoidCallback onPressedPlay;
  final bool isPlay;

  const AlbumSongsRow({
    Key? key,
    required this.aObj,
    required this.onPressed,
    required this.onPressedPlay,
    this.isPlay = false,
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
              child: Text(
                aObj["name"],
                style: TextStyle(
                  color: TColor.primaryText60,
                  fontSize: 13,
                ),
                maxLines: 1,
              ),
            ),
            Text(
              aObj["duration"],
              style: TextStyle(
                color: TColor.primaryText28,
                fontSize: 10,
              ),
              maxLines: 1,
            ),
            Container(
              width: 80,
              alignment: Alignment.centerRight,
              child: isPlay
                  ? Image.asset(
                      AppImages.playEq,
                      width: 60,
                      height: 25,
                    )
                  : Image.asset(
                      AppImages.more,
                      width: 25,
                      height: 25,
                    ),
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
