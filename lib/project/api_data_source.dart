import 'base_network.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadCategories(){
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadArea(){
    return BaseNetwork.get("list.php?a=list");
  }

  Future<Map<String, dynamic>> loadIngredient(){
    return BaseNetwork.get("/list.php?i=list");
  }

  Future<Map<String, dynamic>> loadByCategory({required String category}){
    return BaseNetwork.get("filter.php?c=$category");
  }

  Future<Map<String, dynamic>> loadByAlphabet({required String alphabet}){
    return BaseNetwork.get("search.php?f=$alphabet");
  }

  Future<Map<String, dynamic>> loadByIngredient({required String ingredient}){
    return BaseNetwork.get("filter.php?i=$ingredient");
  }

  Future<Map<String, dynamic>> loadByArea({required String area}){
    return BaseNetwork.get("filter.php?a=$area");
  }

  Future<Map<String, dynamic>> loadRandomDetail(){
    return BaseNetwork.get("random.php");
  }

  Future<Map<String, dynamic>> loadDetail({required String idMeal}){
    return BaseNetwork.get("lookup.php?i=$idMeal");
  }

  Future<Map<String, dynamic>> loadBySearch({required String search}){
    return BaseNetwork.get("search.php?s=$search");
  }

}