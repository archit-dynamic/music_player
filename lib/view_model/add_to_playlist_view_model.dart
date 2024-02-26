import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/firebase/song_queries.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:music_player/model/songs_response.dart';

class AddToPlaylistViewModel extends GetxController {
  RxList<PlaylistModel> playlistList = <PlaylistModel>[].obs;
  RxList<PlaylistModel> selectedPlaylists = <PlaylistModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPlaylists();
  }

  getPlaylists() async {
    playlistList.value = await FirebaseSongQueries().getPlaylists(
          userId: FirebaseAuthenticationQueries().user?.uid ?? "",
        ) ??
        [];
  }

  addToSelectedPlaylist(PlaylistModel playlist) {
    selectedPlaylists.add(playlist);
  }

  addSongToSelectedPlaylists({required Song song}) async {
    final List<String> playlistIds = [
      for (var playlist in selectedPlaylists) playlist.id ?? "",
    ];
    final userId = FirebaseAuthenticationQueries().user?.uid ?? "";
    final result = await FirebaseSongQueries().addSongToMultiplePlaylists(
      playlistIds,
      userId,
      song,
    );
    if (result) {
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Song added!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Error adding song."),
        ),
      );
    }
  }
}
