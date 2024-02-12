import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common_widgets/my_playlist_cell.dart';
import 'package:music_player/common_widgets/playlist_songs_cell.dart';
import 'package:music_player/common_widgets/view_all_section.dart';
import 'package:music_player/view_model/playlist_view_model.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final plVM = Get.put<PlaylistViewModel>(PlaylistViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: plVM.playlistArr.length,
                itemBuilder: (BuildContext context, int index) {
                  var pObj = plVM.playlistArr[index];
                  return PlaylistSongsCell(
                    pObj: pObj,
                    onPressed: () {},
                    onPressedPlay: () {},
                  );
                },
              ),
            ),
            ViewAllSection(
              title: "My Playlist",
              onPressed: () {},
            ),
            SizedBox(
              height: 150,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: plVM.myPlaylistArr.length,
                  itemBuilder: (context, index) {
                    var pObj = plVM.myPlaylistArr[index];
                    return MyPlaylistCell(pObj: pObj, onPressed: () {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff23273B),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset(
            AppImages.add,
          ),
        ),
      ),
    );
  }
}
