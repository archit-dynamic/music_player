import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/player_invoke.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/all_songs_row.dart';
import 'package:music_player/common_widgets/mini_player_view.dart';
import 'package:music_player/common_widgets/search_widget.dart';
import 'package:music_player/view_model/search_view_model.dart';
import 'package:music_player/view_model/splash_view_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchVM = Get.put<SearchViewModel>(SearchViewModel());

    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: AppBar(
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
            title: SearchWidget(
              searchController: searchController,
              onChanged: searchVM.onSearch,
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: searchVM.songsList.length,
              itemBuilder: (context, index) {
                var song = searchVM.songsList[index];
                return VisibilityDetector(
                  key: ValueKey(song.id),
                  onVisibilityChanged: (visibilityInfo) {
                    bool isVisible = visibilityInfo.visibleFraction > 0;
                    if (isVisible && song == searchVM.songsList.last) {
                      searchVM.onLastSongReached(searchController.text);
                    }
                  },
                  child: AllSongsRow(
                    song: song,
                    isWeb: true,
                    onPressed: () {},
                    onPressedPlay: () {
                      Get.find<SplashViewModel>().setCurrentPlayingSong(song);
                      playerPlayProcessDebounce(
                          searchVM.songsList
                              .map((song) => {
                                    "id": song.id.toString(),
                                    "title": song.name.toString(),
                                    "artist": song.primaryArtists.toString(),
                                    "album": song.album.toString(),
                                    "genre": song.language.toString(),
                                    "image": song.image?.last.link.toString(),
                                    "url":
                                        song.downloadUrl?.last.link.toString(),
                                    "user_id": song.primaryArtistsId.toString(),
                                    "user_name": song.primaryArtists.toString(),
                                  })
                              .toList(),
                          index);
                    },
                  ),
                );
              },
            ),
          ),
          MiniPlayerView(),
        ],
      ),
    );
  }
}
