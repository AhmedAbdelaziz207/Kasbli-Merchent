class CategoriesResponse {
  CategoriesResponse();
  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse();
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

class CategoryModel {
  CategoryModel();
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel();
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

class Subcategory {
  final int id;
  final String name;
  final int categoryId;
  Subcategory({required this.id, required this.name, required this.categoryId});
}
