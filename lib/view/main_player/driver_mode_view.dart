import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/view/main_player/play_playlist_view.dart';

class DriverModeView extends StatefulWidget {
  const DriverModeView({Key? key}) : super(key: key);

  @override
  State<DriverModeView> createState() => _DriverModeViewState();
}

class _DriverModeViewState extends State<DriverModeView> {
  final List<String> menuItems = [
    "Social Share",
    "Play Queue",
    "Add to playlist...",
    "Lyrics",
    "Volume",
    "Details",
    "Sleep timer",
    "Equalizer",
    "Driver mode"
  ];

  var sliderVal = 0.7;

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
            AppImages.close,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Driver Mode",
          style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const PlayPlaylistView());
            },
            icon: Image.asset(
              AppImages.playlist,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(media.width * 0.4),
                  child: Image.asset(
                    AppImages.playerImage,
                    width: media.width * 0.4,
                    height: media.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: media.width * 0.4,
                  height: media.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TColor.primaryText28,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(media.width * 0.2),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Black or White",
              style: TextStyle(
                color: TColor.primaryText.withOpacity(0.9),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Michael Jackson \u0387 Album - Dangerous",
              style: TextStyle(
                color: TColor.primaryText60,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "232/327",
              style: TextStyle(
                color: TColor.primaryText60,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Slider(
              value: sliderVal,
              activeColor: TColor.focus,
              inactiveColor: TColor.primaryText28,
              onChanged: (newVal) {
                setState(() {
                  sliderVal = newVal;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "3:35",
                    style: TextStyle(
                      color: TColor.primaryText60,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "4:26",
                    style: TextStyle(
                      color: TColor.primaryText60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.previousSong,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.play,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.nextSong,
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
