import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/album_songs_row.dart';
import 'package:music_player/common_widgets/artist_album_cell.dart';
import 'package:music_player/common_widgets/view_all_section.dart';
import 'package:music_player/view_model/artists_view_model.dart';

class ArtistDetailsView extends StatefulWidget {
  const ArtistDetailsView({Key? key}) : super(key: key);

  @override
  State<ArtistDetailsView> createState() => _ArtistDetailsViewState();
}

class _ArtistDetailsViewState extends State<ArtistDetailsView>
    with SingleTickerProviderStateMixin {
  final artistVM = Get.put<ArtistsViewModel>(ArtistsViewModel());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            AppImages.back,
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Artist Details",
          style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppImages.search,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: TColor.primaryText35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Image.asset(
                        AppImages.artistDetailsTop,
                        width: double.maxFinite,
                        height: media.width * 0.45,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: media.width * 0.45,
                    color: Colors.black45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Dilion Bruce",
                                    style: TextStyle(
                                      color:
                                          TColor.primaryText.withOpacity(0.90),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Pop rock, Funk pop, Heavy Metal",
                                    style: TextStyle(
                                      color:
                                          TColor.primaryText.withOpacity(0.74),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "4,357",
                                  style: TextStyle(
                                    color: TColor.primaryText.withOpacity(0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                    color: TColor.primaryText60,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "128,980",
                                  style: TextStyle(
                                    color: TColor.primaryText.withOpacity(0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Listeners",
                                  style: TextStyle(
                                    color: TColor.primaryText60,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(17.5),
                              child: Container(
                                width: 70,
                                height: 25,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: TColor.primaryG,
                                    begin: Alignment.topCenter,
                                    end: Alignment.center,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: TColor.primaryText
                                            .withOpacity(0.74),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ViewAllSection(
              title: "Top Albums",
              onPressed: () {},
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                scrollDirection: Axis.horizontal,
                itemCount: artistVM.albumsArr.length,
                itemBuilder: (context, index) {
                  var aaObj = artistVM.albumsArr[index];
                  return ArtistAlbumCell(aaObj: aaObj);
                },
              ),
            ),
            ViewAllSection(
              title: "Top Songs",
              onPressed: () {},
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: artistVM.playedArr.length,
              itemBuilder: (context, index) {
                var aObj = artistVM.playedArr[index];
                return AlbumSongsRow(
                  aObj: aObj,
                  isPlay: index == 0,
                  onPressed: () {},
                  onPressedPlay: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
