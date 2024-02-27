import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/model/playlist_model.dart';

class AddToPlaylistRow extends StatefulWidget {
  final Function onSelect;
  final PlaylistModel playList;

  const AddToPlaylistRow({
    Key? key,
    required this.onSelect,
    required this.playList,
  }) : super(key: key);

  @override
  State<AddToPlaylistRow> createState() => _AddToPlaylistRowState();
}

class _AddToPlaylistRowState extends State<AddToPlaylistRow> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: widget.playList.songsList?.isNotEmpty == true
                ? widget.playList.songsList?.first.image?.last.link ?? ""
                : "",
            fit: BoxFit.cover,
            height: 100,
            width: 100,
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
        InkWell(
          onTap: () {
            isSelected = !isSelected;
            debugPrint("isSelected = $isSelected");
            widget.onSelect();
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: isSelected ? TColor.primary : TColor.bg,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? null
                      : Border.all(
                          color: TColor.darkGray,
                          width: 2,
                        ),
                ),
              ),
              Icon(
                Icons.check,
                size: 24,
                color: isSelected ? TColor.primaryText : TColor.bg,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
