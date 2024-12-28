class CourseEntity {
  String courseId;
  String picture;
  bool isFree;
  bool isNew;
  String name;
  String description;
  double price;

  CourseEntity({
    required this.courseId,
    required this.picture,
    required this.isFree,
    required this.isNew,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, Object?> toDocument() {
    return {
      'courseId': courseId,
      'picture': picture,
      'isFree': isFree,
      'isNew': isNew,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  static CourseEntity fromDocument(Map<String, dynamic> doc) {
    return CourseEntity(
        courseId: doc['courseId'],
        picture: doc['picture'],
        isFree: doc['isFree'],
        isNew: doc['isNew'],
        name: doc['name'],
        description: doc['description'],
        price: doc['price']
    );
  }


}
