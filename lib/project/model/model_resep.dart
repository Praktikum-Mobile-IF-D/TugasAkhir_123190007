import 'dart:convert';

class MealList {
  final List<Meals>? meals;

  MealList({
    this.meals,
  });

  MealList.fromJson(Map<String, dynamic> json)
      : meals = (json['meals'] as List?)?.map((dynamic e) => Meals.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'meals' : meals?.map((e) => e.toJson()).toList()
  };
}

class Meals {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;
  final String? strArea;

  Meals({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.strArea
  });

  Meals.fromJson(Map<String, dynamic> json)
      : strMeal = json['strMeal'] as String?,
        strMealThumb = json['strMealThumb'] as String?,
        idMeal = json['idMeal'] as String?,
        strArea = json['strArea'] as String?;

  Map<String, dynamic> toJson() => {
    'strMeal' : strMeal,
    'strMealThumb' : strMealThumb,
    'idMeal' : idMeal,
    'strArea' : strArea
  };
}
