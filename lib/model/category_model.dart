class CategoryModel {
  int id;
  String name;
  int image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromMap({required Map m1}) {
    return CategoryModel(
      id: m1['category_id'],
      name: m1['c_name'],
      image: m1['c_image'],
    );
  }
}
