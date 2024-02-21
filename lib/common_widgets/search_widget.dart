import 'package:flutter/material.dart';
import 'package:music_player/common/color_extensions.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController searchController;

  const SearchWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: TColor.darkGray,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: TextField(
        controller: widget.searchController,
        maxLines: 1,
        showCursor: true,
        cursorColor: TColor.primaryText,
        decoration: InputDecoration(
          hintText: "Search songs here",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: TColor.primaryText60,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
