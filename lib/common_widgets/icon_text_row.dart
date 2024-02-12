import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class IconTextRow extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const IconTextRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 44,
          child: ListTile(
            leading: Image.asset(
              icon,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: TColor.primaryText.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: onTap,
          ),
        ),
        Divider(
          color: TColor.primaryText.withOpacity(0.07),
          indent: 70,
        ),
      ],
    );
  }
}
