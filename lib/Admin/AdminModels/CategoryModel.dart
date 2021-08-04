class CategoryModel {
  String categoryId;
  String name;

  CategoryModel({this.categoryId, this.name});

  Map<String, dynamic> toMap() {
    return {'id': categoryId, 'Speciality': name};
  }

  factory CategoryModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;
    return CategoryModel(
      categoryId: firestore['id'],
      name: firestore['Speciality'],
    );
  }
}
