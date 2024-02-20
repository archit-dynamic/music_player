import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/playlist_songs_row.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PlayPlaylistView extends StatefulWidget {
  const PlayPlaylistView({Key? key}) : super(key: key);

  @override
  State<PlayPlaylistView> createState() => _PlayPlaylistViewState();
}

class _PlayPlaylistViewState extends State<PlayPlaylistView> {
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
      key: const Key("playlistScreen"),
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
            "Playlist",
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
              onSelected: (selectIndex) {},
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(media.width * 0.4),
                        child: Image.asset(
                          AppImages.playerImage,
                          width: media.width * 0.4,
                          height: media.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: media.width * 0.4,
                        height: media.width * 0.4,
                        child: SleekCircularSlider(
                          min: 0,
                          max: 100,
                          initialValue: 60,
                          appearance: CircularSliderAppearance(
                              customWidths: CustomSliderWidths(
                                trackWidth: 2,
                                progressBarWidth: 4,
                                shadowWidth: 6,
                              ),
                              customColors: CustomSliderColors(
                                dotColor: const Color(0xffFFB1B2),
                                trackColor:
                                    const Color(0xffffffff).withOpacity(0.3),
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
              const SizedBox(
                height: 10,
              ),
              Text(
                "3:15|4:26",
                style: TextStyle(
                  color: TColor.primaryText80,
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
                  color: TColor.primaryText80,
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: pageManager.playlistNotifier,
                  builder: (context, queue, _) {
                    final int queueStateIndex = pageManager
                                .currentSongNotifier.value ==
                            null
                        ? 0
                        : queue.indexOf(pageManager.currentSongNotifier.value!);

                    final num queuePosition = queue.length - queueStateIndex;

                    return Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: ReorderableListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: queue.length,
                        onReorder: (oldIndex, newIndex) {
                          if (oldIndex < newIndex) {
                            newIndex--;
                          }
                          pageManager.moveMediaItem(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          var sObj = queue[index];
                          return Dismissible(
                            key: ValueKey(sObj.id),
                            direction: index == queueStateIndex
                                ? DismissDirection.none
                                : DismissDirection.horizontal,
                            onDismissed: (direction) {
                              pageManager.removeQueueItemAt(index);
                            },
                            child: PlaylistSongsRow(
                              sObj: sObj,
                              onPressed: () {
                                pageManager.skipToQueueItem(index);
                                if (pageManager.playButtonNotifier.value ==
                                    ButtonState.paused) {
                                  pageManager.play();
                                }
                              },
                              right: index == queueStateIndex
                                  ? Icon(
                                      Icons.bar_chart_rounded,
                                      color: TColor.primary,
                                    )
                                  : ReorderableDragStartListener(
                                      key: ValueKey(sObj.id),
                                      enabled: index != queueStateIndex,
                                      index: index,
                                      child: Icon(
                                        Icons.drag_handle_rounded,
                                        color: TColor.primaryText,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
