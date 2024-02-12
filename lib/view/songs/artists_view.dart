import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common_widgets/artist_row.dart';
import 'package:music_player/view/songs/artist_details_view.dart';
import 'package:music_player/view_model/artists_view_model.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({Key? key}) : super(key: key);

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  final artistVM = Get.put<ArtistsViewModel>(ArtistsViewModel());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          itemCount: artistVM.allList.length,
          itemBuilder: (context, index) {
            var aObj = artistVM.allList[index];
            return ArtistRow(
              aObj: aObj,
              onPressed: () {
                Get.to(() => const ArtistDetailsView());
              },
              onPressedMenuSelect: (selectIndex) {},
            );
          },
        ),
      ),
    );
  }
}
