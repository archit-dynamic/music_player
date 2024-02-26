import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/model/songs_response.dart';
import 'package:music_player/view/login/login_view.dart';
import 'package:music_player/view/main_tabview/main_tabview.dart';

class SplashViewModel extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Song? currentPlayingSong;

  void loadView() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    if (FirebaseAuthenticationQueries().user != null) {
      Get.to(() => const MainTabView());
    } else {
      Get.to(() => const LogInView());
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }

  void setCurrentPlayingSong(Song song) {
    currentPlayingSong = song;
  }

  Song? getCurrentPlayingSong() {
    return currentPlayingSong;
  }
}
