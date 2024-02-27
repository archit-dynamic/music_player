import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/icon_text_row.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/view/login/login_view.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var splashVM = Get.find<SplashViewModel>();

    return Drawer(
      backgroundColor: const Color(0xff10121D),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 240,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: TColor.primaryText.withOpacity(0.03),
              ),
              child: Column(
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    width: media.width * 0.17,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "328\nSongs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffc1c0c0), fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "52\nAlbums",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffc1c0c0), fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "87\nArtists",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffc1c0c0), fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          IconTextRow(
            title: "Themes",
            icon: AppImages.mTheme,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Ringtone Cutter",
            icon: AppImages.mRingCut,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Sleep Timer",
            icon: AppImages.mSleepTimer,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Equalizer",
            icon: AppImages.mEq,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Driver Mode",
            icon: AppImages.mDriverMode,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Hidden Folder",
            icon: AppImages.mHiddenFolder,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Scan Media",
            icon: AppImages.mScanMedia,
            onTap: () {
              splashVM.closeDrawer();
            },
          ),
          IconTextRow(
            title: "Logout",
            icon: AppImages.mScanMedia,
            onTap: () {
              FirebaseAuthenticationQueries().signOut();
              Get.to(() => const LogInView());
            },
          ),
        ],
      ),
    );
  }
}
