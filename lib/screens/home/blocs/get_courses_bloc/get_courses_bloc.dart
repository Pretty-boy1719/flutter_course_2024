import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'get_courses_event.dart';
part 'get_courses_state.dart';

class GetCoursesBloc extends Bloc<GetCoursesEvent, GetCoursesState> {
  final CourseRepo _courseRepo;

  GetCoursesBloc(this._courseRepo) : super(GetCoursesInitial()) {
    on<GetCourses>((event, emit) async {
      emit(GetCoursesProcess());
      try{
        List<Course> courses = await _courseRepo.getCourses();
        emit(GetCoursesSuccess(courses));
      }
      catch(e){
        emit(GetCoursesFailure());
      }
    });
  }
}
