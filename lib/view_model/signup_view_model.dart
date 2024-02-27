import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/firebase/song_queries.dart';
import 'package:music_player/view/main_tabview/main_tabview.dart';

class SignupViewModel extends GetxController {
  signUpUser({required String email, required String password}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      User? user = await FirebaseAuthenticationQueries().signUpUser(
        email: email,
        password: password,
      );
      if (user != null) {
        Get.to(() => const MainTabView());
        afterSignUpProcess(user);
      }
    }
  }

  afterSignUpProcess(User user) {
    createFavSongsPlaylist(userId: user.uid);
  }

  createFavSongsPlaylist({
    required String userId,
  }) {
    FirebaseSongQueries()
        .addPlaylist(userId: userId, playlistName: "Favourites");
  }
}
