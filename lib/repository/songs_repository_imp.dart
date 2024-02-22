import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_player/common/api_endpoints.dart';
import 'package:music_player/model/songs_model.dart';
import 'package:music_player/repository/songs_repository.dart';

class SongsRepositoryImp extends SongsRepository {
  final dio = Dio();

  @override
  Future<Either<String, SongModel>> searchSongs({
    required String query,
    int pageNo = 1,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        "${ApiEndpoints.getSongs}query=$query&page=$pageNo&limit=$limit",
      );
      if (response.statusCode == 200) {
        debugPrint("searchSongs response : $response");
        return Right(SongModel.fromJson(response.data));
      } else {
        return left("Error in fetching songs. Please try again.");
      }
    } on DioException catch (e) {
      debugPrint("Error: $e");
      return left("Error in fetching songs. Please try again.");
    }
  }
}
