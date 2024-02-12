import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/common_widgets/icon_text_row.dart';
import 'package:music_player/view_model/splash_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
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
          "Settings",
          style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          IconTextRow(
            icon: AppImages.sDisplay,
            title: "Display",
            onTap: () {},
          ),
          IconTextRow(
            icon: AppImages.sAudio,
            title: "Audio",
            onTap: () {},
          ),
          IconTextRow(
            icon: AppImages.sHeadset,
            title: "Headset",
            onTap: () {},
          ),
          IconTextRow(
            icon: AppImages.sLockScreen,
            title: "Lock Screen",
            onTap: () {},
          ),
          IconTextRow(
            icon: AppImages.sMenu,
            title: "Advanced",
            onTap: () {},
          ),
          IconTextRow(
            icon: AppImages.sOther,
            title: "Other",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
