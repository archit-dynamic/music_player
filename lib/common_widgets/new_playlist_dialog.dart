import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/firebase/song_queries.dart';

class NewPlaylistDialog extends StatelessWidget {
  NewPlaylistDialog({Key? key}) : super(key: key);

  final TextEditingController nameController =
      TextEditingController(text: "My playlist");

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 300,
        width: 400,
        color: TColor.bg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Give your playlist a name",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
              controller: nameController,
              showCursor: true,
              cursorColor: TColor.primaryText,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "My playlist",
                hintStyle: TextStyle(
                  color: TColor.primaryText60,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: TColor.primary,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: TColor.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    Get.back();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: TColor.bg,
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(
                        color: TColor.darkGray,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: TColor.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    String userId =
                        FirebaseAuthenticationQueries().user?.uid ?? "";
                    if (nameController.text.isNotEmpty && userId.isNotEmpty) {
                      bool result = await FirebaseSongQueries().addPlaylist(
                        userId: userId,
                        playlistName: nameController.text,
                      );
                      if (result) {
                        Get.back();
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(
                            content: Text("Playlist created."),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(
                            content: Text("Error in creating playlist."),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: TColor.primary,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Text(
                      "Create",
                      style: TextStyle(
                        color: TColor.bg,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
