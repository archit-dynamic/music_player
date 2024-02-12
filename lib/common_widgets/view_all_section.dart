import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class ViewAllSection extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback onPressed;

  const ViewAllSection(
      {Key? key,
      required this.title,
      this.buttonTitle = "view all",
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: TColor.primaryText80,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: TColor.org,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
