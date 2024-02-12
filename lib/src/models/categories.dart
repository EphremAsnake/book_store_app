class CategoryModel {
  final int? id;
  final String? name;
  final String? path;

  CategoryModel({this.id, this.name, this.path});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      path: json['path'] ?? '',
    );
  }
}
