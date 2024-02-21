import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/view/main_player/play_playlist_view.dart';

class DriverModeView extends StatefulWidget {
  const DriverModeView({Key? key}) : super(key: key);

  @override
  State<DriverModeView> createState() => _DriverModeViewState();
}

class _DriverModeViewState extends State<DriverModeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    final pageManager = getIt<PageManager>();

    return Dismissible(
      key: const Key("driverModelScreen"),
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
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) => const PlayPlaylistView(),
                  ),
                );
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
        body: ValueListenableBuilder<MediaItem?>(
            valueListenable: pageManager.currentSongNotifier,
            builder: (context, mediaItem, _) {
              if (mediaItem == null) return const SizedBox();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Hero(
                          tag: "currentArtWork",
                          child: ValueListenableBuilder<MediaItem?>(
                            valueListenable: pageManager.currentSongNotifier,
                            builder: (context, value, _) {
                              return ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(media.width * 0.2),
                                child: CachedNetworkImage(
                                  imageUrl: mediaItem.artUri.toString(),
                                  fit: BoxFit.cover,
                                  width: media.width * 0.4,
                                  height: media.width * 0.4,
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
                        Container(
                          width: media.width * 0.4,
                          height: media.width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: TColor.primaryText28,
                              width: 2,
                            ),
                            borderRadius:
                                BorderRadius.circular(media.width * 0.2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
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
                        color: TColor.primaryText60,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
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

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Slider(
                            value: value,
                            activeColor: TColor.focus,
                            inactiveColor: TColor.primaryText28,
                            min: 0,
                            max: max(
                              valueState.current.inMilliseconds.toDouble(),
                              valueState.total.inMilliseconds.toDouble(),
                            ),
                            onChanged: (newVal) {
                              if (!dragging) {
                                dragging = true;
                              }
                              setState(() {
                                dragValue = newVal;
                              });

                              pageManager.seek(
                                Duration(
                                  milliseconds: newVal.round(),
                                ),
                              );
                            },
                            onChangeEnd: (value) {
                              pageManager.seek(
                                Duration(
                                  milliseconds: value.round(),
                                ),
                              );
                              dragging = false;
                            },
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: pageManager.progressNotifier,
                        builder: (context, valueState, child) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                          .firstMatch("${valueState.current}")
                                          ?.group(1) ??
                                      "${valueState.current}",
                                  style: TextStyle(
                                    color: TColor.primaryText60,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                          .firstMatch("${valueState.total}")
                                          ?.group(1) ??
                                      "${valueState.total}",
                                  style: TextStyle(
                                    color: TColor.primaryText60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isFirstSongNotifier,
                          builder: (context, isFirst, child) {
                            return SizedBox(
                              width: 60,
                              height: 60,
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
                        ValueListenableBuilder<ButtonState>(
                          valueListenable: pageManager.playButtonNotifier,
                          builder: (context, value, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                if (value == ButtonState.loading)
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        TColor.primaryText,
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: value == ButtonState.playing
                                      ? InkWell(
                                          onTap: pageManager.pause,
                                          child: Icon(
                                            Icons.pause_rounded,
                                            color: TColor.primaryText,
                                            size: 80,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: pageManager.play,
                                          child: Icon(
                                            Icons.play_circle_filled_rounded,
                                            color: TColor.primaryText,
                                            size: 80,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: pageManager.isLastSongNotifier,
                          builder: (context, isLast, child) {
                            return SizedBox(
                              width: 60,
                              height: 60,
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
                  ],
                ),
              );
            }),
      ),
    );
  }
}
