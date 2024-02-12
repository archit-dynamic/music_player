import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class AllSongsRow extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressed;
  final VoidCallback onPressedPlay;

  const AllSongsRow({
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
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    sObj["image"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.primaryText28,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: TColor.bg,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
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
                      color: TColor.primaryText28,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onPressedPlay,
              icon: Image.asset(
                AppImages.playBtn,
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
