// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

List<Pets> petsFromJson(String str) => List<Pets>.from(json.decode(str).map((x) => Pets.fromJson(x)));

String petsToJson(List<Pets> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pets {
  Pets({
    this.id,
    this.age,
    this.sex,
    this.name,
    this.type,
    this.breed,
    this.image,
    this.distance,
    this.description,
  });

  int id;
  Age age;
  Sex sex;
  String name;
  Type type;
  String breed;
  String image;
  int distance;
  String description;

  factory Pets.fromJson(Map<String, dynamic> json) => Pets(
    id: json["id"],
    age: ageValues.map[json["age"]],
    sex: sexValues.map[json["sex"]],
    name: json["name"],
    type: typeValues.map[json["type"]],
    breed: json["breed"],
    image: json["image"] == null ? null : json["image"],
    distance: json["distance"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": ageValues.reverse[age],
    "sex": sexValues.reverse[sex],
    "name": name,
    "type": typeValues.reverse[type],
    "breed": breed,
    "image": image == null ? null : image,
    "distance": distance,
    "description": description,
  };
}

enum Age { ADULT, SENIOR, YOUNG }

final ageValues = EnumValues({
  "Adult": Age.ADULT,
  "Senior": Age.SENIOR,
  "Young": Age.YOUNG
});

enum Sex { MALE, FEMALE }

final sexValues = EnumValues({
  "Female": Sex.FEMALE,
  "Male": Sex.MALE
});

enum Type { DOG }

final typeValues = EnumValues({
  "dog": Type.DOG
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
