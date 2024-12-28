import 'package:course_repository/src/entities/course_entities.dart';

class Course{
  String courseId;
  String picture;
  bool isFree;
  bool isNew;
  String name;
  String description;
  int price;

  Course({
    required this.courseId,
    required this.picture,
    required this.isFree,
    required this.isNew,
    required this.name,
    required this.description,
    required this.price,
  });

  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      picture: picture,
      isFree: isFree,
      isNew: isNew,
      name: name,
      description: description,
      price: price
    );
  }

  // обратно из сущности (json), в объект класса
  static Course fromEntity(CourseEntity entity) {
    return Course(
        courseId: entity.courseId,
        picture: entity.picture,
        isFree: entity.isFree,
        isNew: entity.isNew,
        name: entity.name,
        description: entity.description,
        price: entity.price
    );
  }

}