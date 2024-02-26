// To parse this JSON data, do
//
//     final song = songFromJson(jsonString);

import 'dart:convert';

SongResponse songResponseFromJson(String str) =>
    SongResponse.fromJson(json.decode(str));

String songResponseToJson(SongResponse data) => json.encode(data.toJson());

class SongResponse {
  String? status;
  dynamic message;
  SongData? data;

  SongResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SongResponse.fromJson(Map<String, dynamic> json) => SongResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : SongData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class SongData {
  int? total;
  int? start;
  List<Song>? songs;

  SongData({
    this.total,
    this.start,
    this.songs,
  });

  factory SongData.fromJson(Map<String, dynamic> json) => SongData(
        total: json["total"],
        start: json["start"],
        songs: json["results"] == null
            ? []
            : List<Song>.from(json["results"].map((x) => Song.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "start": start,
        "results": List<dynamic>.from(songs!.map((x) => x.toJson())),
      };
}

class Song {
  String? id;
  String? name;
  String? type;
  Album? album;
  String? year;
  dynamic releaseDate;
  String? duration;
  String? label;
  String? primaryArtists;
  String? primaryArtistsId;
  String? featuredArtists;
  String? featuredArtistsId;
  int? explicitContent;
  String? playCount;
  String? language;
  String? hasLyrics;
  String? url;
  String? copyright;
  List<DownloadUrl>? image;
  List<DownloadUrl>? downloadUrl;

  Song({
    this.id,
    this.name,
    this.type,
    this.album,
    this.year,
    this.releaseDate,
    this.duration,
    this.label,
    this.primaryArtists,
    this.primaryArtistsId,
    this.featuredArtists,
    this.featuredArtistsId,
    this.explicitContent,
    this.playCount,
    this.language,
    this.hasLyrics,
    this.url,
    this.copyright,
    this.image,
    this.downloadUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        year: json["year"],
        releaseDate: json["releaseDate"],
        duration: json["duration"],
        label: json["label"],
        primaryArtists: json["primaryArtists"],
        primaryArtistsId: json["primaryArtistsId"],
        featuredArtists: json["featuredArtists"],
        featuredArtistsId: json["featuredArtistsId"],
        explicitContent: json["explicitContent"],
        playCount: json["playCount"],
        language: json["language"],
        hasLyrics: json["hasLyrics"],
        url: json["url"],
        copyright: json["copyright"],
        image: json["image"] == null
            ? []
            : List<DownloadUrl>.from(
                json["image"].map((x) => DownloadUrl.fromJson(x))),
        downloadUrl: json["downloadUrl"] == null
            ? []
            : List<DownloadUrl>.from(
                json["downloadUrl"].map((x) => DownloadUrl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "album": album!.toJson(),
        "year": year,
        "releaseDate": releaseDate,
        "duration": duration,
        "label": label,
        "primaryArtists": primaryArtists,
        "primaryArtistsId": primaryArtistsId,
        "featuredArtists": featuredArtists,
        "featuredArtistsId": featuredArtistsId,
        "explicitContent": explicitContent,
        "playCount": playCount,
        "language": language,
        "hasLyrics": hasLyrics,
        "url": url,
        "copyright": copyright,
        "image": List<dynamic>.from(image!.map((x) => x.toJson())),
        "downloadUrl": List<dynamic>.from(downloadUrl!.map((x) => x.toJson())),
      };
}

class Album {
  String? id;
  String? name;
  String? url;

  Album({
    this.id,
    this.name,
    this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class DownloadUrl {
  Quality? quality;
  String? link;

  DownloadUrl({
    this.quality,
    this.link,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) => DownloadUrl(
        quality: qualityValues.map[json["quality"]]!,
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "quality": qualityValues.reverse[quality],
        "link": link,
      };
}

enum Quality {
  THE_12_KBPS,
  THE_150_X150,
  THE_160_KBPS,
  THE_320_KBPS,
  THE_48_KBPS,
  THE_500_X500,
  THE_50_X50,
  THE_96_KBPS
}

final qualityValues = EnumValues({
  "12kbps": Quality.THE_12_KBPS,
  "150x150": Quality.THE_150_X150,
  "160kbps": Quality.THE_160_KBPS,
  "320kbps": Quality.THE_320_KBPS,
  "48kbps": Quality.THE_48_KBPS,
  "500x500": Quality.THE_500_X500,
  "50x50": Quality.THE_50_X50,
  "96kbps": Quality.THE_96_KBPS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
