import 'package:course_repository/src/models/course.dart';

abstract class CourseRepo {
    Future<List<Course>> getCourses();
}