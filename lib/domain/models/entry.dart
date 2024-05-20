import 'dart:convert';

import 'package:floor/floor.dart';


@entity
class Entry {
  @primaryKey
  int id;
  String name;
  String image;
  String description;
  String commonLocations;
  String category;
  Entry({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.commonLocations,
    required this.category,
  });

  Entry copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    String? commonLocation,
    String? category,
  }) {
    return Entry(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      commonLocations: commonLocation ?? commonLocations,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'commonLocation': commonLocations,
      'category': category,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      commonLocations: jsonEncode(map['common_locations'] ?? ['Sem Localização']),
      category: map['category'] as String,
    );
  }

  List<String> commonLocationsConverter() {
    return (jsonDecode(commonLocations) as List<dynamic>).map((e) => e as String).toList();
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Entry(id: $id, name: $name, image: $image, description: $description, commonLocation: $commonLocations, category: $category)';
  }

  @override
  bool operator ==(covariant Entry other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.description == description &&
        other.commonLocations == commonLocations &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        description.hashCode ^
        commonLocations.hashCode ^
        category.hashCode;
  }
}
