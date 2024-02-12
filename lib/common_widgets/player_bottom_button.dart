import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class PlayerBottomButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const PlayerBottomButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              onPressed: onPressed,
              icon: Image.asset(
                icon,
                color: TColor.primaryText80,
                height: 30,
                width: 30,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: TColor.secondaryText,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
