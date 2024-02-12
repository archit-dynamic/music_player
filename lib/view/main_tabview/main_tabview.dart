import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/home_drawer.dart';
import 'package:music_player/common_widgets/mini_player_view.dart';
import 'package:music_player/view/home/home_view.dart';
import 'package:music_player/view/settings/settings_view.dart';
import 'package:music_player/view/songs/songs_view.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 3,
      vsync: this,
    );
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var splashVM = Get.find<SplashViewModel>();

    return Scaffold(
      key: splashVM.scaffoldKey,
      drawer: const HomeDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: controller,
            children: const [
              HomeView(),
              SongsView(),
              SettingsView(),
            ],
          ),
          MiniPlayerView(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: TColor.bg,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            indicatorWeight: 1,
            labelColor: TColor.primary,
            labelStyle: const TextStyle(
              fontSize: 10,
            ),
            unselectedLabelColor: TColor.primaryText28,
            unselectedLabelStyle: const TextStyle(
              fontSize: 10,
            ),
            tabs: [
              Tab(
                text: "Home",
                icon: Image.asset(
                  selectTab == 0 ? AppImages.homeTab : AppImages.homeTabUn,
                  width: 20,
                  height: 20,
                ),
              ),
              Tab(
                text: "Songs",
                icon: Image.asset(
                  selectTab == 1 ? AppImages.songsTab : AppImages.songsTabUn,
                  width: 20,
                  height: 20,
                ),
              ),
              Tab(
                text: "Settings",
                icon: Image.asset(
                  selectTab == 2
                      ? AppImages.settingsTab
                      : AppImages.settingsTabUn,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
