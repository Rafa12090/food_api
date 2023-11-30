

class Ingredient {
  String name;
  String image;

  Ingredient({
    required this.name,
    required this.image,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    name : json['name'],
    image : json['image'],
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}