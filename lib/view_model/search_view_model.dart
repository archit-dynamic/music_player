import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:music_player/model/songs_model.dart';
import 'package:music_player/repository/songs_repository.dart';
import 'package:music_player/repository/songs_repository_imp.dart';
import 'package:music_player/utils/debouncer_util.dart';

class SearchViewModel extends GetxController {
  SongsRepository songsRepository = SongsRepositoryImp();
  RxInt currentPageNumber = 1.obs;
  RxBool isLoading = false.obs;
  RxString error = "".obs;
  RxList<Song> songsList = <Song>[].obs;
  final deBouncer = DeBouncer(milliseconds: 500);

  void onSearch(String query) {
    deBouncer.run(() {
      searchSongs(query);
    });
  }

  Future<void> searchSongs(String query) async {
    isLoading.value = true;
    final Either<String, SongModel> result = await songsRepository.searchSongs(
      query: query,
      limit: 20,
      pageNo: currentPageNumber.value,
    );
    isLoading.value = false;
    result.fold(
      (l) {
        error.value = l;
      },
      (r) {
        songsList.value = r.data?.songs ?? [];
      },
    );
  }
}