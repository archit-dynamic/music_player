import 'dart:ui' as ui;

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/control_buttons.dart';
import 'package:music_player/view/main_player/main_player_view.dart';

class MiniPlayerView extends StatefulWidget {
  static const MiniPlayerView _instance = MiniPlayerView._internal();

  factory MiniPlayerView() {
    return _instance;
  }

  const MiniPlayerView._internal();

  @override
  State<MiniPlayerView> createState() => _MiniPlayerViewState();
}

class _MiniPlayerViewState extends State<MiniPlayerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return ValueListenableBuilder<AudioProcessingState>(
      valueListenable: pageManager.playbackStatNotifier,
      builder: (context, processingState, _) {
        if (processingState == AudioProcessingState.idle) {
          return const SizedBox();
        }
        return ValueListenableBuilder<MediaItem?>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (context, mediaItem, _) {
            if (mediaItem == null) return const SizedBox();
            return Dismissible(
              key: const Key("mini_player"),
              direction: DismissDirection.down,
              onDismissed: (direction) {
                Feedback.forLongPress(context);
                pageManager.stop();
              },
              child: ValueListenableBuilder(
                  valueListenable: pageManager.playlistNotifier,
                  builder: (context, queue, _) {
                    return Dismissible(
                      key: Key(mediaItem.id),
                      confirmDismiss: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          if (mediaItem.id == queue.first.id) {
                            pageManager.skipToQueueItem(queue.length - 1);
                          } else {
                            pageManager.previous();
                          }
                        } else {
                          if (mediaItem.id == queue.last.id) {
                            pageManager.skipToQueueItem(0);
                          } else {
                            pageManager.next();
                          }
                        }
                        return Future.value(false);
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.white10,
                        child: SizedBox(
                          height: 76,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(
                                sigmaX: 8,
                                sigmaY: 8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ValueListenableBuilder<ProgressBarState>(
                                    valueListenable:
                                        pageManager.progressNotifier,
                                    builder: (context, value, _) {
                                      final position = value.current;
                                      final totalDuration = value.total;
                                      return position == null
                                          ? const SizedBox()
                                          : (position.inSeconds.toDouble() <
                                                      0.0 ||
                                                  (position.inSeconds
                                                          .toDouble() >
                                                      totalDuration.inSeconds
                                                          .toDouble()))
                                              ? const SizedBox()
                                              : SliderTheme(
                                                  data: SliderThemeData(
                                                    activeTrackColor:
                                                        TColor.focus,
                                                    inactiveTrackColor:
                                                        Colors.transparent,
                                                    trackHeight: 3,
                                                    thumbColor: TColor.focus,
                                                    thumbShape:
                                                        const RoundSliderOverlayShape(
                                                      overlayRadius: 1.5,
                                                    ),
                                                    overlayColor:
                                                        Colors.transparent,
                                                    overlayShape:
                                                        const RoundSliderOverlayShape(
                                                      overlayRadius: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Slider(
                                                      inactiveColor:
                                                          Colors.transparent,
                                                      value: position.inSeconds
                                                          .toDouble(),
                                                      max: totalDuration
                                                          .inSeconds
                                                          .toDouble(),
                                                      onChanged: (newPosition) {
                                                        pageManager.seek(
                                                          Duration(
                                                            seconds: newPosition
                                                                .round(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                    },
                                  ),
                                  ListTile(
                                    dense: false,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, __, ___) =>
                                              const MainPlayerView(),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      mediaItem.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      mediaItem.artist ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    leading: Hero(
                                      tag: "currentArtWork",
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: SizedBox.square(
                                          dimension: 40,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: CachedNetworkImage(
                                                  imageUrl: mediaItem.artUri
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  width: 40,
                                                  height: 40,
                                                  errorWidget:
                                                      (context, url, error) {
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
                                              ),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: TColor.primaryText28,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  color: TColor.bg,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    trailing: const ControlButtons(
                                      miniPlayer: true,
                                      buttons: [
                                        "Play/Pause",
                                        "Next",
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        );
      },
    );
  }
}
