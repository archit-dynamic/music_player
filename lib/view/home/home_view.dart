import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/playlist_cell.dart';
import 'package:music_player/common_widgets/recommended_cell.dart';
import 'package:music_player/common_widgets/songs_row.dart';
import 'package:music_player/common_widgets/title_section.dart';
import 'package:music_player/common_widgets/view_all_section.dart';
import 'package:music_player/view_model/home_view_model.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeVM = Get.put<HomeViewModel>(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
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
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 38,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color(0xFF292E4B),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: TextField(
                  controller: homeVM.txtSearch.value,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 20,
                      ),
                      hintText: "Search album song",
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                        ),
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Image.asset(
                          AppImages.search,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: TColor.primaryText28,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: TColor.primaryText28,
                        fontSize: 13,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleSection(title: "Hot Recommended"),
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: homeVM.hostRecommendedList.length,
                itemBuilder: (context, index) {
                  var mObj = homeVM.hostRecommendedList[index];
                  return RecommendedCell(mObj: mObj);
                },
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(title: "Playlist", onPressed: () {}),
            SizedBox(
              height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                itemCount: homeVM.playListArr.length,
                itemBuilder: (context, index) {
                  var mObj = homeVM.playListArr[index];
                  return PlaylistCell(mObj: mObj);
                },
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(title: "Recently Played", onPressed: () {}),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: homeVM.recentlyPlayedArr.length,
              itemBuilder: (context, index) {
                var sObj = homeVM.recentlyPlayedArr[index];
                return SongsRow(
                  sObj: sObj,
                  onPressed: () {},
                  onPressedPlay: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
