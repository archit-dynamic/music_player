import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common_widgets/album_cell.dart';
import 'package:music_player/view/songs/album_details_view.dart';
import 'package:music_player/view_model/albums_view_model.dart';

class AlbumsView extends StatefulWidget {
  const AlbumsView({Key? key}) : super(key: key);

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final albumVM = Get.put<AlbumViewModel>(AlbumViewModel());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var cellWidth = (media.width - 40 - 20) * 0.5;

    return Scaffold(
      body: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            childAspectRatio: cellWidth / (cellWidth + 45),
          ),
          itemCount: albumVM.allList.length,
          itemBuilder: (context, index) {
            var aObj = albumVM.allList[index];
            return AlbumCell(
              aObj: aObj,
              onPressed: () {
                Get.to(() => const AlbumDetailsView());
              },
              onPressedMenu: (index) {
                debugPrint("$index");
              },
            );
          },
        ),
      ),
    );
  }
}
