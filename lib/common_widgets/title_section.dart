import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class TitleSection extends StatelessWidget {
  final String title;

  const TitleSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20,
      ),
      child: Text(
        title,
        style: TextStyle(
            color: TColor.primaryText80,
            fontSize: 15,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
