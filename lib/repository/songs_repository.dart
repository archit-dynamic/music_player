import 'package:dartz/dartz.dart';
import 'package:music_player/model/songs_response.dart';

abstract class SongsRepository {
  Future<Either<String, SongResponse>> searchSongs({
    required String query,
    int pageNo = 1,
    int limit = 20,
  });
}
