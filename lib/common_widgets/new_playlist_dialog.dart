import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/view_model/add_to_playlist_view_model.dart';

class NewPlaylistDialog extends StatelessWidget {
  NewPlaylistDialog({Key? key}) : super(key: key);

  final TextEditingController nameController =
      TextEditingController(text: "My playlist");
  final addToPlaylistVM =
      Get.put<AddToPlaylistViewModel>(AddToPlaylistViewModel());

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
                    addToPlaylistVM.onCreatePlaylistClick(nameController.text);
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
