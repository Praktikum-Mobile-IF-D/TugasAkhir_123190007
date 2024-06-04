class IngredientList {
  final List<Meals>? meals;

  IngredientList({
    this.meals,
  });

  IngredientList.fromJson(Map<String, dynamic> json)
      : meals = (json['meals'] as List?)?.map((dynamic e) => Meals.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'meals' : meals?.map((e) => e.toJson()).toList()
  };
}

class Meals {
  final String? idIngredient;
  final String? strIngredient;
  final String? strDescription;
  final dynamic strType;

  Meals({
    this.idIngredient,
    this.strIngredient,
    this.strDescription,
    this.strType,
  });

  Meals.fromJson(Map<String, dynamic> json)
      : idIngredient = json['idIngredient'] as String?,
        strIngredient = json['strIngredient'] as String?,
        strDescription = json['strDescription'] as String?,
        strType = json['strType'];

  Map<String, dynamic> toJson() => {
    'idIngredient' : idIngredient,
    'strIngredient' : strIngredient,
    'strDescription' : strDescription,
    'strType' : strType
  };
}