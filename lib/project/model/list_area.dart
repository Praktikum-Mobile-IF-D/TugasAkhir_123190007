class AreaList {
  final List<Meals>? meals;

  AreaList({
    this.meals,
  });

  AreaList.fromJson(Map<String, dynamic> json)
      : meals = (json['meals'] as List?)?.map((dynamic e) => Meals.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'meals' : meals?.map((e) => e.toJson()).toList()
  };
}

class Meals {
  final String? strArea;

  Meals({
    this.strArea,
  });

  Meals.fromJson(Map<String, dynamic> json)
      : strArea = json['strArea'] as String?;

  Map<String, dynamic> toJson() => {
    'strArea' : strArea
  };
}