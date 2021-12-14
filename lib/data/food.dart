class FoodType {
  String? docId;
  final int id;
  final String title;
  final String image;
  final int calorie;
  final bool isPacked;
  final int? packWeigth;

  FoodType({
    this.docId,
    required this.id,
    required this.title,
    required this.image,
    required this.calorie,
    required this.isPacked,
    this.packWeigth,
  });

  factory FoodType.fromJson({
    required Map<String, dynamic> data,
    required String docId,
  }) {
    int id = (data['id'] as num).toInt();
    String title = data['title'];
    String image = data['image'];
    int calorie = (data['calorie'] as num).toInt();
    bool isPacked = data['isPacked'] as bool;
    int? packWeigth = (data['packWeigth'] as num).toInt();
    return FoodType(
      id: id,
      title: title,
      image: image,
      calorie: calorie,
      isPacked: isPacked,
      packWeigth: packWeigth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'calorie': calorie,
      'isPacked': isPacked,
      'packWeigth': packWeigth,
    };
  }
}
