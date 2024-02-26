import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class AlbumCell extends StatelessWidget {
  final Map aObj;
  final VoidCallback onPressed;
  final Function(int) onPressedMenu;

  AlbumCell({
    Key? key,
    required this.aObj,
    required this.onPressed,
    required this.onPressedMenu,
  }) : super(key: key);

  final List<String> menuItems = [
    "Play",
    "Play Next",
    "Add to playing queue",
    "Add to playlist...",
    "Rename",
    "Tag Editor",
    "Go to artist",
    "Delete from device",
    "Share"
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              aObj["image"],
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    aObj["name"],
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  width: 12,
                  height: 12,
                  child: PopupMenuButton<int>(
                    color: const Color(0xff383b49),
                    offset: const Offset(-10, 15),
                    icon: Image.asset(
                      AppImages.moreBtn,
                      width: 12,
                      height: 12,
                    ),
                    padding: EdgeInsets.zero,
                    onSelected: onPressedMenu,
                    elevation: 1,
                    itemBuilder: (context) {
                      return [
                        for (int i = 0; i < menuItems.length; i++)
                          PopupMenuItem(
                            value: i + 1,
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Text(
                              menuItems[i],
                              style: TextStyle(
                                fontSize: 12,
                                color: TColor.primaryText,
                              ),
                            ),
                          ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  aObj["artists"],
                  style: TextStyle(
                    color: TColor.lightGray,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                ),
              ),
              Text(
                " \u0387 ",
                style: TextStyle(
                  color: TColor.lightGray,
                  fontSize: 15,
                ),
                maxLines: 1,
              ),
              Text(
                aObj["songs"],
                style: TextStyle(
                  color: TColor.lightGray,
                  fontSize: 11,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
