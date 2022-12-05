import 'package:json_annotation/json_annotation.dart';

part 'kakao_data.g.dart'; // 꼭 있어야 함

@JsonSerializable()
class KakaoData {
  Meta meta;
  // Documents documents;
  // List<>

  KakaoData({
    required this.meta,
    // required this.documents,
  });

  factory KakaoData.fromJson(Map<String, dynamic> json) => _$KakaoDataFromJson(json);
  Map<String, dynamic> toJson() => _$KakaoDataToJson(this);
}


@JsonSerializable()
class Meta {
  Meta({
    required this.total_count,
    required this.pageable_count,
    required this.is_end,
  });

  @JsonKey(name: 'total_count')
  int total_count;
  @JsonKey(name: 'pageable_count')
  int pageable_count;
  @JsonKey(name: 'is_end')
  bool is_end;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

// @JsonSerializable()
// class Documents {
//   Documents({
//     required this.collection,
//     required this.datetime,
//     required this.display_sitename,
//     required this.doc_url,
//     required this.image_url,
//     required this.thumbnail_url,
//     required this.height,
//     required this.width,
//   });
//
//   @JsonKey(name: 'collection')
//   String collection;
//   @JsonKey(name: 'datetime')
//   String datetime;
//   @JsonKey(name: 'display_sitename')
//   String display_sitename;
//   @JsonKey(name: 'doc_url')
//   String doc_url;
//   @JsonKey(name: 'image_url')
//   String image_url;
//   @JsonKey(name: 'thumbnail_url')
//   String thumbnail_url;
//   @JsonKey(name: 'height')
//   int height;
//   @JsonKey(name: 'width')
//   int width;
//
//   /// 수정전
//   // factory Documents.fromJson(Map<String, dynamic> json) => _$DocumentsFromJson(json);
//   // Map<String, dynamic> toJson() => _$DocumentsToJson(this);
//   /// 수정 후
//   factory Documents.fromJson(List<Map<String, dynamic>> json) => _$DocumentsFromJson(json);
//   List<Map<String, dynamic>> toJson() => _$DocumentsToJson(this);
// }
