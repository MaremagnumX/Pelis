import 'dart:convert';

CreditstResponse creditstResponseFromJson(String str) =>
    CreditstResponse.fromJson(json.decode(str));

String creditstResponseToJson(CreditstResponse data) =>
    json.encode(data.toJson());

class CreditstResponse {
  final int id;
  final List<Cast> cast;
  final List<Cast> crew;

  CreditstResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CreditstResponse.fromJson(Map<String, dynamic> json) =>
      CreditstResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Cast {
  final bool adult;
  final int gender;
  final int id;
  final Department knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;
  final Department? department;
  final String? job;

  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: departmentValues.map[json["department"]]!,
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": departmentValues.reverse[department],
        "job": job,
      };
}

enum Department {
  acting,
  art,
  camera,
  costumeMakeUp,
  crew,
  directing,
  editing,
  lighting,
  production,
  sound,
  visualEffects,
  writing
}

final departmentValues = EnumValues({
  "Acting": Department.acting,
  "Art": Department.art,
  "Camera": Department.camera,
  "Costume & Make-Up": Department.costumeMakeUp,
  "Crew": Department.crew,
  "Directing": Department.directing,
  "Editing": Department.editing,
  "Lighting": Department.lighting,
  "Production": Department.production,
  "Sound": Department.sound,
  "Visual Effects": Department.visualEffects,
  "Writing": Department.writing
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
