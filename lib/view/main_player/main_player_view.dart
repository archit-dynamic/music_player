import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/player_bottom_button.dart';
import 'package:music_player/view/main_player/driver_mode_view.dart';
import 'package:music_player/view/main_player/play_playlist_view.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MainPlayerView extends StatefulWidget {
  const MainPlayerView({Key? key}) : super(key: key);

  @override
  State<MainPlayerView> createState() => _MainPlayerViewState();
}

class _MainPlayerViewState extends State<MainPlayerView> {
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
          "Now Playing",
          style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            color: const Color(0xff383b49),
            offset: const Offset(-20, 45),
            icon: Image.asset(
              AppImages.moreBtn,
              width: 20,
              height: 20,
            ),
            padding: EdgeInsets.zero,
            onSelected: (selectIndex) {
              if (selectIndex == 9) {
                Get.to(() => const DriverModeView());
              }
            },
            elevation: 1,
            itemBuilder: (context) {
              return [
                for (int i = 0; i < menuItems.length; i++)
                  PopupMenuItem(
                    value: i + 1,
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      menuItems[i],
                      style: TextStyle(
                        fontSize: 12,
                        color: TColor.primaryText,
                      ),
                    ),
                  ),
              ];
            },
          ),
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
                  borderRadius: BorderRadius.circular(media.width * 0.7),
                  child: Image.asset(
                    AppImages.playerImage,
                    width: media.width * 0.6,
                    height: media.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: media.width * 0.6,
                  height: media.width * 0.6,
                  child: SleekCircularSlider(
                    min: 0,
                    max: 100,
                    initialValue: 60,
                    appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          trackWidth: 4,
                          progressBarWidth: 6,
                          shadowWidth: 8,
                        ),
                        customColors: CustomSliderColors(
                          dotColor: const Color(0xffFFB1B2),
                          trackColor: const Color(0xffffffff).withOpacity(0.3),
                          progressBarColors: [
                            const Color(0xffFB9967),
                            const Color(0xffE9585A)
                          ],
                          shadowColor: const Color(0xffFFB1B2),
                          shadowMaxOpacity: 0.05,
                        ),
                        infoProperties: InfoProperties(
                          topLabelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          topLabelText: 'Elapsed',
                          bottomLabelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          bottomLabelText: 'time',
                          mainLabelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        startAngle: 270,
                        angleRange: 360,
                        size: 350.0),
                    onChange: (double value) {
                      // callback providing a value while its being changed (with a pan gesture)
                    },
                    onChangeStart: (double startValue) {
                      // callback providing a starting value (when a pan gesture starts)
                    },
                    onChangeEnd: (double endValue) {
                      // callback providing an ending value (when a pan gesture ends)
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "3:15|4:26",
              style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 25,
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
                color: TColor.secondaryText,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              AppImages.eqDisplay,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Divider(
                color: Colors.white24,
                height: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.previousSong,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.play,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppImages.nextSong,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerBottomButton(
                  title: "Playlist",
                  icon: AppImages.playlist,
                  onPressed: () {
                    Get.to(() => const PlayPlaylistView());
                  },
                ),
                PlayerBottomButton(
                  title: "Shuffle",
                  icon: AppImages.shuffle,
                  onPressed: () {},
                ),
                PlayerBottomButton(
                  title: "Repeat",
                  icon: AppImages.repeat,
                  onPressed: () {},
                ),
                PlayerBottomButton(
                  title: "EQ",
                  icon: AppImages.eq,
                  onPressed: () {},
                ),
                PlayerBottomButton(
                  title: "Favourites",
                  icon: AppImages.fav,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
