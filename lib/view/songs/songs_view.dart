import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/view/search/search_view.dart';
import 'package:music_player/view/songs/albums_view.dart';
import 'package:music_player/view/songs/all_songs_view.dart';
import 'package:music_player/view/songs/artists_view.dart';
import 'package:music_player/view/songs/genres_view.dart';
import 'package:music_player/view/songs/playlist_view.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class SongsView extends StatefulWidget {
  const SongsView({Key? key}) : super(key: key);

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 5,
      vsync: this,
    );
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.find<SplashViewModel>().openDrawer();
          },
          icon: Image.asset(
            AppImages.menu,
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Songs",
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
                  pageBuilder: (_, __, ___) => const SearchView(),
                ),
              );
            },
            icon: Image.asset(
              AppImages.search,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: TColor.primaryText35,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight - 15,
            child: TabBar(
              controller: controller,
              indicatorColor: TColor.focus,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
              isScrollable: true,
              labelColor: TColor.focus,
              labelStyle: TextStyle(
                color: TColor.focus,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelColor: TColor.primaryText80,
              unselectedLabelStyle: TextStyle(
                color: TColor.primaryText80,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(
                  text: "All Songs",
                ),
                Tab(
                  text: "Playlist",
                ),
                Tab(
                  text: "Album",
                ),
                Tab(
                  text: "Artists",
                ),
                Tab(
                  text: "Genres",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                AllSongsView(),
                PlaylistView(),
                AlbumsView(),
                ArtistsView(),
                GenresView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
