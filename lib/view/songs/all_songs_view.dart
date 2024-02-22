import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/player_invoke.dart';
import 'package:music_player/common_widgets/all_songs_row.dart';
import 'package:music_player/model/songs_model.dart';
import 'package:music_player/view_model/all_songs_view_model.dart';

class AllSongsView extends StatefulWidget {
  const AllSongsView({Key? key}) : super(key: key);

  @override
  State<AllSongsView> createState() => _AllSongsViewState();
}

class _AllSongsViewState extends State<AllSongsView> {
  final allVM = Get.put<AllSongsViewModel>(AllSongsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: allVM.allList.length,
          itemBuilder: (context, index) {
            var sObj = allVM.allList[index];
            Song song = Song(
              id: sObj["id"].toString(),
              name: sObj["name"].toString(),
              primaryArtists: sObj["primaryArtists"].toString(),
              album: Album(id: "", name: sObj["album"].toString(), url: ""),
              image: [
                DownloadUrl(
                    quality: Quality.THE_500_X500,
                    link: sObj["image"].toString())
              ],
              downloadUrl: [
                DownloadUrl(
                    quality: Quality.THE_500_X500,
                    link: sObj["downloadUrl"].toString())
              ],
            );
            return AllSongsRow(
              song: song,
              isWeb: true,
              onPressed: () {},
              onPressedPlay: () {
                // Get.to(() => const MainPlayerView());
                playerPlayProcessDebounce(
                    allVM.allList
                        .map((sObj) => {
                              "id": sObj["id"].toString(),
                              "title": sObj["name"].toString(),
                              "artist": sObj["primaryArtists"].toString(),
                              "album": sObj["album"].toString(),
                              "genre": sObj["language"].toString(),
                              "image": sObj["image"].toString(),
                              "url": sObj["downloadUrl"].toString(),
                              "user_id": sObj["primaryArtistsId"].toString(),
                              "user_name": sObj["primaryArtists"].toString(),
                            })
                        .toList(),
                    index);
              },
            );
          },
        ),
      ),
    );
  }
}
