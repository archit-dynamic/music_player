import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/model/playlist_model.dart';

class MyPlaylistCell extends StatelessWidget {
  final PlaylistModel playlist;
  final VoidCallback onPressed;

  const MyPlaylistCell({
    Key? key,
    required this.playlist,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: playlist.songsList?.first.image?.last.link ?? "",
                    fit: BoxFit.cover,
                    width: 90,
                    height: 80,
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        AppImages.alb1,
                        fit: BoxFit.cover,
                      );
                    },
                    placeholder: (context, url) {
                      return Image.asset(
                        AppImages.alb1,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Container(
                  width: 90,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: TColor.primaryText28,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              playlist.name ?? "",
              style: TextStyle(
                color: TColor.primaryText60,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
