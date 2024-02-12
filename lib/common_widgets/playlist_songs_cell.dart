import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class PlaylistSongsCell extends StatelessWidget {
  final Map pObj;
  final VoidCallback onPressed;
  final VoidCallback onPressedPlay;

  const PlaylistSongsCell({
    Key? key,
    required this.pObj,
    required this.onPressed,
    required this.onPressedPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          pObj["image"],
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black45,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pObj["name"],
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      pObj["songs"],
                      style: TextStyle(
                        color: TColor.primaryText28,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onPressedPlay,
                child: Image.asset(
                  AppImages.play,
                  width: 22,
                  height: 22,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
