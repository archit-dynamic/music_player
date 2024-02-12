import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common_widgets/genres_cell.dart';
import 'package:music_player/view_model/genres_view_model.dart';

class GenresView extends StatefulWidget {
  const GenresView({Key? key}) : super(key: key);

  @override
  State<GenresView> createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> {
  final genVM = Get.put<GenresViewModel>(GenresViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.4,
        ),
        itemCount: genVM.allList.length,
        itemBuilder: (context, index) {
          var cObj = genVM.allList[index];
          return GenresCell(
            cObj: cObj,
            onPressed: () {},
          );
        },
      ),
    );
  }
}
