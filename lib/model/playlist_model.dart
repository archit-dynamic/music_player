import 'package:music_player/model/songs_response.dart';

class PlaylistModel {
  String? id;
  String? name;
  int? count;
  List<Song>? songsList;

  PlaylistModel({
    this.id,
    this.name,
    this.count,
    this.songsList,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        id: json["id"],
        name: json["name"],
        count: json["count"],
        songsList: json["songsList"] == null
            ? []
            : List<Song>.from(json["songsList"].map((x) => Song.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
        "songsList": List<dynamic>.from(songsList!.map((x) => x.toJson())),
      };
}
