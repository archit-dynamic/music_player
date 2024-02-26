import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/player_invoke.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/all_songs_row.dart';
import 'package:music_player/common_widgets/mini_player_view.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:music_player/view_model/playlist_view_model.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class PlaylistDetailsView extends StatefulWidget {
  final PlaylistModel playlist;

  const PlaylistDetailsView({Key? key, required this.playlist})
      : super(key: key);

  @override
  State<PlaylistDetailsView> createState() => _PlaylistDetailsViewState();
}

class _PlaylistDetailsViewState extends State<PlaylistDetailsView> {
  final songsList = Get.find<PlaylistViewModel>().playListSongs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: TColor.bg,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            AppImages.back,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Songs",
          style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              CachedNetworkImage(
                imageUrl:
                    widget.playlist.songsList?.first.image?.last.link ?? "",
                fit: BoxFit.cover,
                width: MediaQuery.sizeOf(context).width * 0.6,
                height: MediaQuery.sizeOf(context).width * 0.6,
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
              const SizedBox(
                height: 32,
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: songsList.length,
                  itemBuilder: (context, index) {
                    var song = songsList[index];
                    return AllSongsRow(
                      song: song,
                      isWeb: true,
                      onPressed: () {},
                      onPressedPlay: () {
                        Get.find<SplashViewModel>().setCurrentPlayingSong(song);
                        playerPlayProcessDebounce(
                            songsList
                                .map((song) => {
                                      "id": song.id.toString(),
                                      "title": song.name.toString(),
                                      "artist": song.primaryArtists.toString(),
                                      "album": song.album.toString(),
                                      "genre": song.language.toString(),
                                      "image": song.image?.last.link.toString(),
                                      "url": song.downloadUrl?.last.link
                                          .toString(),
                                      "user_id":
                                          song.primaryArtistsId.toString(),
                                      "user_name":
                                          song.primaryArtists.toString(),
                                    })
                                .toList(),
                            index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          MiniPlayerView(),
        ],
      ),
    );
  }
}
