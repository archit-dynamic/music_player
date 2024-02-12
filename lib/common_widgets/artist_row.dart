import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class ArtistRow extends StatelessWidget {
  final Map aObj;
  final VoidCallback onPressed;
  final Function(int select) onPressedMenuSelect;

  ArtistRow({
    Key? key,
    required this.aObj,
    required this.onPressed,
    required this.onPressedMenuSelect,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    aObj["image"],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.primaryText28,
                    ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    aObj["name"],
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${aObj["albums"]} \t \u0387 \t${aObj["songs"]}",
                    style: TextStyle(
                      color: TColor.primaryText80,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25,
              height: 25,
              child: PopupMenuButton<int>(
                color: const Color(0xff383b49),
                offset: const Offset(-10, 25),
                icon: Image.asset(
                  AppImages.moreBtn,
                  width: 20,
                  height: 20,
                ),
                padding: EdgeInsets.zero,
                onSelected: onPressedMenuSelect,
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
    );
  }
}
