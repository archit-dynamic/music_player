import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/player_invoke.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/all_songs_row.dart';
import 'package:music_player/common_widgets/search_widget.dart';
import 'package:music_player/view_model/all_songs_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final allVM = Get.put<AllSongsViewModel>(AllSongsViewModel());

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
        title: SearchWidget(
          searchController: searchController,
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: TColor.bg,
        child: Obx(
          () => ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: allVM.allList.length,
            itemBuilder: (context, index) {
              var sObj = allVM.allList[index];
              return AllSongsRow(
                sObj: sObj,
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
      ),
    );
  }
}
