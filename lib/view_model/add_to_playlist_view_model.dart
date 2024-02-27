import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/firebase/song_queries.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:music_player/model/songs_response.dart';
import 'package:music_player/view_model/playlist_view_model.dart';

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
    if (selectedPlaylists.isNotEmpty) {
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
    } else {
      Get.back();
    }
  }

  onCreatePlaylistClick(String playlistName) async {
    String userId = FirebaseAuthenticationQueries().user?.uid ?? "";
    if (userId.isNotEmpty) {
      bool result = await FirebaseSongQueries().addPlaylist(
        userId: userId,
        playlistName: playlistName == "" ? "My playlist" : playlistName,
      );
      if (result) {
        Get.back();
        getPlaylists();
        if (Get.isRegistered<PlaylistViewModel>()) {
          Get.find<PlaylistViewModel>().getPlaylists();
        }
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Playlist created."),
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Error in creating playlist."),
          ),
        );
      }
    }
  }

  onEditPlaylistClick({
    required String playlistName,
    required String playlistId,
  }) async {
    String userId = FirebaseAuthenticationQueries().user?.uid ?? "";
    if (userId.isNotEmpty) {
      bool result = await FirebaseSongQueries().editPlaylist(
        userId: userId,
        playlistId: playlistId,
        newPlaylistName: playlistName == "" ? "My playlist" : playlistName,
      );
      if (result) {
        Get.back();
        getPlaylists();
        if (Get.isRegistered<PlaylistViewModel>()) {
          Get.find<PlaylistViewModel>().getPlaylists();
        }
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Playlist edited."),
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Error in editing playlist."),
          ),
        );
      }
    }
  }
}
