import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/player_bottom_button.dart';
import 'package:music_player/model/songs_response.dart';
import 'package:music_player/view/add_to_playlist/add_to_playlist_view.dart';
import 'package:music_player/view/main_player/driver_mode_view.dart';
import 'package:music_player/view/main_player/play_playlist_view.dart';
import 'package:music_player/view_model/splash_view_model.dart';
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
    final pageManager = getIt<PageManager>();

    return Dismissible(
      key: const Key("playScreen"),
      direction: DismissDirection.down,
      background: const ColoredBox(color: Colors.transparent),
      onDismissed: (direction) {
        Get.back();
      },
      child: Scaffold(
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
                if (selectIndex == 2) {
                  openPlaylistQueue();
                } else if (selectIndex == 9) {
                  openDriverModel();
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
        body: ValueListenableBuilder<MediaItem?>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (context, mediaItem, _) {
            if (mediaItem == null) return const SizedBox();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                          tag: "currentArtWork",
                          child: ValueListenableBuilder<MediaItem?>(
                            valueListenable: pageManager.currentSongNotifier,
                            builder: (context, value, _) {
                              return ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(media.width * 0.7),
                                child: CachedNetworkImage(
                                  imageUrl: mediaItem.artUri.toString(),
                                  fit: BoxFit.cover,
                                  width: media.width * 0.6,
                                  height: media.width * 0.6,
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      AppImages.appLogo,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Image.asset(
                                      AppImages.appLogo,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: pageManager.progressNotifier,
                          builder: (context, valueState, _) {
                            double? dragValue;
                            bool dragging = false;

                            final value = min(
                              valueState.current.inMilliseconds.toDouble(),
                              valueState.total.inMilliseconds.toDouble(),
                            );

                            if (dragValue != null && dragging) {
                              dragValue = null;
                            }

                            return SizedBox(
                              width: media.width * 0.6,
                              height: media.width * 0.6,
                              child: SleekCircularSlider(
                                min: 0,
                                max: max(
                                  valueState.current.inMilliseconds.toDouble(),
                                  valueState.total.inMilliseconds.toDouble(),
                                ),
                                initialValue: value,
                                appearance: CircularSliderAppearance(
                                    customWidths: CustomSliderWidths(
                                      trackWidth: 4,
                                      progressBarWidth: 6,
                                      shadowWidth: 8,
                                    ),
                                    customColors: CustomSliderColors(
                                      dotColor: const Color(0xffFFB1B2),
                                      trackColor: const Color(0xffffffff)
                                          .withOpacity(0.3),
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
                                  if (!dragging) {
                                    dragging = true;
                                  }
                                  setState(() {
                                    dragValue = value;
                                  });

                                  pageManager.seek(
                                    Duration(
                                      milliseconds: value.round(),
                                    ),
                                  );
                                  // setState(() {});
                                },
                                onChangeStart: (double startValue) {},
                                onChangeEnd: (double endValue) {
                                  pageManager.seek(
                                    Duration(
                                      milliseconds: endValue.round(),
                                    ),
                                  );
                                  dragging = false;
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: pageManager.progressNotifier,
                      builder: (context, valueState, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                      .firstMatch("${valueState.current}")
                                      ?.group(1) ??
                                  "${valueState.current}",
                              style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " | ",
                              style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                      .firstMatch("${valueState.total}")
                                      ?.group(1) ??
                                  "${valueState.total}",
                              style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      mediaItem.title,
                      textAlign: TextAlign.center,
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
                      "${mediaItem.artist} \u0387 Album - ${mediaItem.album}",
                      textAlign: TextAlign.center,
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
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(
                        color: Colors.white24,
                        height: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isFirstSongNotifier,
                          builder: (context, isFirst, child) {
                            return SizedBox(
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed:
                                    isFirst ? null : pageManager.previous,
                                icon: Image.asset(
                                  AppImages.previousSong,
                                  color: isFirst
                                      ? TColor.primaryText35
                                      : TColor.primaryText,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ValueListenableBuilder<ButtonState>(
                          valueListenable: pageManager.playButtonNotifier,
                          builder: (context, value, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                if (value == ButtonState.loading)
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        TColor.primaryText,
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: value == ButtonState.playing
                                      ? InkWell(
                                          onTap: pageManager.pause,
                                          child: Icon(
                                            Icons.pause_rounded,
                                            color: TColor.primaryText,
                                            size: 60,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: pageManager.play,
                                          child: Icon(
                                            Icons.play_circle_filled_rounded,
                                            color: TColor.primaryText,
                                            size: 60,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isLastSongNotifier,
                          builder: (context, isLast, child) {
                            return SizedBox(
                              width: 45,
                              height: 45,
                              child: IconButton(
                                onPressed: isLast ? null : pageManager.next,
                                icon: Image.asset(
                                  AppImages.nextSong,
                                  color: isLast
                                      ? TColor.primaryText35
                                      : TColor.primaryText,
                                ),
                              ),
                            );
                          },
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
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (_, __, ___) =>
                                    const PlayPlaylistView(),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                            valueListenable:
                                pageManager.isShuffleModeEnabledNotifier,
                            builder: (context, value, child) {
                              return PlayerBottomButton(
                                title: "Shuffle",
                                icon: AppImages.shuffle,
                                isSelected: value,
                                onPressed: () {
                                  if (value) {
                                    pageManager.setShuffleMode(
                                        AudioServiceShuffleMode.none);
                                  } else {
                                    pageManager.setShuffleMode(
                                        AudioServiceShuffleMode.all);
                                    pageManager.setRepeatMode(
                                        AudioServiceRepeatMode.none);
                                  }
                                },
                              );
                            }),
                        ValueListenableBuilder<RepeatState>(
                            valueListenable: pageManager.repeatButtonNotifier,
                            builder: (context, value, child) {
                              return PlayerBottomButton(
                                title: "Repeat",
                                icon: AppImages.repeat,
                                isSelected: value == RepeatState.repeatSong,
                                onPressed: () {
                                  if (value == RepeatState.repeatSong) {
                                    pageManager.setRepeatMode(
                                        AudioServiceRepeatMode.none);
                                  } else if (value == RepeatState.off) {
                                    pageManager.setRepeatMode(
                                        AudioServiceRepeatMode.one);
                                    pageManager.setShuffleMode(
                                        AudioServiceShuffleMode.none);
                                  }
                                },
                              );
                            }),
                        PlayerBottomButton(
                          title: "EQ",
                          icon: AppImages.eq,
                          onPressed: () {},
                        ),
                        PlayerBottomButton(
                          title: "Add to playlist",
                          icon: AppImages.add,
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (_, __, ___) => AddToPlaylistView(
                                  song: Get.find<SplashViewModel>()
                                          .getCurrentPlayingSong() ??
                                      Song(),
                                ),
                              ),
                            );
                          },
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
          },
        ),
      ),
    );
  }

  void openPlaylistQueue() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => const PlayPlaylistView(),
      ),
    );
  }

  void openDriverModel() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => const DriverModeView(),
      ),
    );
  }
}
