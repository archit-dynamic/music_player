import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/add_to_playlist_row.dart';
import 'package:music_player/common_widgets/new_playlist_dialog.dart';
import 'package:music_player/model/songs_response.dart';
import 'package:music_player/view_model/add_to_playlist_view_model.dart';

class AddToPlaylistView extends StatefulWidget {
  final Song song;

  const AddToPlaylistView({Key? key, required this.song}) : super(key: key);

  @override
  State<AddToPlaylistView> createState() => _AddToPlaylistViewState();
}

class _AddToPlaylistViewState extends State<AddToPlaylistView> {
  final addToPlaylistVM =
      Get.put<AddToPlaylistViewModel>(AddToPlaylistViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.delete<AddToPlaylistViewModel>();
          },
          icon: Image.asset(
            AppImages.back,
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Add to playlist",
          style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return NewPlaylistDialog();
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: TColor.primaryText,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Text(
                        "New playlist",
                        style: TextStyle(
                          color: TColor.bg,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addToPlaylistVM.playlistList.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemBuilder: (context, index) {
                        final playlist = addToPlaylistVM.playlistList[index];
                        return AddToPlaylistRow(
                          onSelect: () {
                            addToPlaylistVM.addToSelectedPlaylist(playlist);
                          },
                          playList: playlist,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (addToPlaylistVM.playlistList.isNotEmpty) {
                return Positioned(
                  bottom: 0,
                  left: (MediaQuery.sizeOf(context).width / 2) - 75,
                  child: InkWell(
                    onTap: () {
                      addToPlaylistVM.addSongToSelectedPlaylists(
                          song: widget.song);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: TColor.primary,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: TColor.bg,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
            Container(
              height: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
