import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_repository/course_repository.dart';
import 'package:courses_repository/src/models/course.dart';

class FirebaseCourseRepo implements CourseRepo{
  final courseCollection = FirebaseFirestore.instance.collection('courses');

  Future<List<Course>> getCourses() async {
    try{
      return await courseCollection
          .get()
          .then((value) => value.docs.map((e) =>
            Course.fromEntity(CourseEntity.fromDocument(e.data()))
      ).toList());
    }
    catch(e) {
      log(e.toString());
      rethrow;
    }
  }
}