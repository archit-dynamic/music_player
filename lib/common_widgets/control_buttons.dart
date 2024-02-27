import 'package:flutter/material.dart';
import 'package:music_player/audio_helpers/page_manager.dart';
import 'package:music_player/audio_helpers/service_locator.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';

class ControlButtons extends StatelessWidget {
  final bool shuffle;
  final bool miniPlayer;
  final List buttons;

  const ControlButtons(
      {Key? key,
      this.shuffle = false,
      this.miniPlayer = false,
      this.buttons = const [
        "Previous",
        "Play/Pause",
        "Next",
      ]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: buttons.map((e) {
        switch (e) {
          case "Previous":
            return ValueListenableBuilder<bool>(
              valueListenable: pageManager.isFirstSongNotifier,
              builder: (context, isFirst, _) {
                return ValueListenableBuilder(
                    valueListenable: pageManager.playlistNotifier,
                    builder: (context, queue, _) {
                      return IconButton(
                        onPressed: isFirst
                            ? () {
                                pageManager.skipToQueueItem(queue.length - 1);
                              }
                            : pageManager.previous,
                        icon: Image.asset(
                          AppImages.previousSong,
                          width: miniPlayer ? 20 : 50,
                          height: miniPlayer ? 20 : 50,
                        ),
                      );
                    });
              },
            );
          case "Play/Pause":
            return SizedBox(
              width: miniPlayer ? 40 : 70,
              height: miniPlayer ? 40 : 70,
              child: ValueListenableBuilder<ButtonState>(
                valueListenable: pageManager.playButtonNotifier,
                builder: (context, value, _) {
                  return Stack(
                    children: [
                      if (value == ButtonState.loading)
                        Center(
                          child: SizedBox(
                            width: miniPlayer ? 40 : 70,
                            height: miniPlayer ? 40 : 70,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                TColor.primaryText,
                              ),
                            ),
                          ),
                        ),
                      if (miniPlayer)
                        Center(
                          child: value == ButtonState.playing
                              ? IconButton(
                                  onPressed: pageManager.pause,
                                  icon: Icon(
                                    Icons.pause_rounded,
                                    color: TColor.primaryText,
                                  ),
                                )
                              : IconButton(
                                  onPressed: pageManager.play,
                                  icon: Image.asset(
                                    AppImages.play,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                        )
                      else
                        Center(
                          child: value == ButtonState.playing
                              ? IconButton(
                                  onPressed: pageManager.pause,
                                  icon: Icon(
                                    Icons.pause_rounded,
                                    color: TColor.primaryText,
                                    size: 50,
                                  ),
                                )
                              : IconButton(
                                  onPressed: pageManager.play,
                                  icon: Image.asset(
                                    AppImages.play,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                        ),
                    ],
                  );
                },
              ),
            );
          case "Next":
            return ValueListenableBuilder<bool>(
              valueListenable: pageManager.isLastSongNotifier,
              builder: (context, isLast, _) {
                return IconButton(
                  onPressed: isLast
                      ? () {
                          pageManager.skipToQueueItem(0);
                        }
                      : pageManager.next,
                  icon: Image.asset(
                    AppImages.nextSong,
                    width: miniPlayer ? 20 : 50,
                    height: miniPlayer ? 20 : 50,
                  ),
                );
              },
            );
          default:
            return Container();
        }
      }).toList(),
    );
  }
}
