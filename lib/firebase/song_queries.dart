import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:music_player/model/songs_response.dart';
import 'package:uuid/uuid.dart';

final db = FirebaseFirestore.instance;

class FirebaseSongQueries {
  Future<List<Song>?> getPlaylistSongs({
    required String userId,
    required String playlistId,
  }) async {
    try {
      // Get a reference to the playlist document
      DocumentReference playlistRef = db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId);

      // Get the current list of songs
      List<Song> songsList = [];
      DocumentSnapshot playlistDoc = await playlistRef.get();
      debugPrint("playlistDoc ${playlistDoc.data()}");
      ((playlistDoc.data() as Map<String, dynamic>)["songsList"] as List)
          .forEach((element) {
        songsList.add(Song.fromJson(element));
      });

      debugPrint('Fetched playlist successfully!');
      return songsList;
    } catch (e) {
      debugPrint('Error fetching playlist: $e');
      return null;
    }
  }

  Future<List<PlaylistModel>?> getPlaylists({
    required String userId,
  }) async {
    try {
      // Get a reference to the playlist document
      CollectionReference playlistRef =
          db.collection('users').doc(userId).collection('playlists');

      // Get the current list of playlist
      QuerySnapshot playlists = await playlistRef.get();
      debugPrint("playlistDoc.data() ${playlists.docs}");
      final List<PlaylistModel> list = [];
      for (QueryDocumentSnapshot<Object?> element in playlists.docs) {
        list.add(
            PlaylistModel.fromJson(element.data() as Map<String, dynamic>));
      }
      debugPrint('Fetched all playlist successfully!');
      return list;
    } catch (e) {
      debugPrint('Error fetching all playlist: $e');
      return null;
    }
  }

  Future<bool> addPlaylist({
    required String userId,
    required String playlistName,
  }) async {
    String playlistId = const Uuid().v4();

    Map<String, dynamic> playlistData = {
      "id": playlistId,
      'count': 0,
      'name': playlistName,
      'songsList': [],
    };

    try {
      await db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId)
          .set(playlistData);
      debugPrint('Playlist added successfully!');
      return true;
    } catch (e) {
      debugPrint('Error adding playlist: $e');
      return false;
    }
  }

  /* Future<void> addSongToPlaylist({
    required String userId,
    required String playlistId,
    required String song,
  }) async {
    try {
      // Get a reference to the playlist document
      DocumentReference playlistRef = db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId);

      // Get the current list of songs
      List<dynamic> songsList = [];
      DocumentSnapshot playlistDoc = await playlistRef.get();
      if (playlistDoc.data() != null) {
        debugPrint("playlistDoc.data() ${playlistDoc.data()}");
        // List<dynamic> songsList = List.from(playlistDoc.data());
      }

      // Add the new song
      songsList.add(song);

      // Update the playlist document with the updated songsList
      await playlistRef.update({'songsList': songsList});

      debugPrint('Song added to playlist successfully!');
    } catch (e) {
      debugPrint('Error adding song to playlist: $e');
    }
  }*/

  void removeSongFromPlaylist({
    required String userId,
    required String playlistId,
    required String songId,
  }) async {
    try {
      // Get a reference to the playlist document
      DocumentReference playlistRef = db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId);

      // Get the current list of songs
      List<Song> songsList = [];
      DocumentSnapshot playlistDoc = await playlistRef.get();
      if (playlistDoc.data() != null) {
        debugPrint("playlistDoc.data() ${playlistDoc.data()}");
        // List<dynamic> songsList = List.from(playlistDoc.data());
      }

      // Remove song
      songsList.removeWhere((song) => song.id == songId);

      // Update the playlist document with the updated songsList
      await playlistRef.update({'songsList': songsList});

      debugPrint('Song removed from playlist successfully!');
    } catch (e) {
      debugPrint('Error removing song from playlist: $e');
    }
  }

  Future<bool> addSongToMultiplePlaylists(
      List<String> playlistIds, String userId, Song song) async {
    WriteBatch batch = db.batch();

    try {
      // Iterate through each playlist and update the songsList
      for (String playlistId in playlistIds) {
        DocumentReference playlistRef = db
            .collection('users')
            .doc(userId)
            .collection('playlists')
            .doc(playlistId);
        batch.update(playlistRef, {
          'songsList': FieldValue.arrayUnion([song.toJson()])
        });
      }

      // Commit the batched write
      await batch.commit();

      debugPrint('Song added to multiple playlists successfully!');
      return true;
    } catch (e) {
      debugPrint('Error adding song to multiple playlists: $e');
      return false;
    }
  }

  Future<bool> editPlaylist({
    required String userId,
    required String playlistId,
    required String newPlaylistName,
  }) async {
    try {
      // Get a reference to the playlist document
      DocumentReference playlistRef = db
          .collection('users')
          .doc(userId)
          .collection('playlists')
          .doc(playlistId);
      await playlistRef.update({'name': newPlaylistName});

      debugPrint('Playlist edited successfully.');
      return true;
    } catch (e) {
      debugPrint('Error editing playlist: $e');
      return false;
    }
  }
}
