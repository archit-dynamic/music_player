import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class PlaylistSongsRow extends StatelessWidget {
  final MediaItem sObj;
  final VoidCallback onPressed;
  final Widget right;

  const PlaylistSongsRow({
    Key? key,
    required this.sObj,
    required this.onPressed,
    required this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl: sObj.artUri.toString(),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          AppImages.appLogo,
                          fit: BoxFit.cover,
                        );
                      },
                      placeholder: (context, url) {
                        return Image.asset(
                          AppImages.appLogo,
                          fit: BoxFit.cover,
                        );
                      },
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
                      sObj.title,
                      style: TextStyle(
                        color: TColor.primaryText60,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      sObj.artist ?? "",
                      style: TextStyle(
                        color: TColor.primaryText28,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              right,
            ],
          ),
          Divider(
            color: Colors.white.withOpacity(0.07),
            indent: 50,
          ),
        ],
      ),
    );
  }
}
