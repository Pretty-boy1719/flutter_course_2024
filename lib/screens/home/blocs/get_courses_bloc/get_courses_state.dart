part of 'get_courses_bloc.dart';

@immutable
sealed class GetCoursesState extends Equatable {
  const GetCoursesState();

  @override
  List<Object> get props => [];
}

final class GetCoursesInitial extends GetCoursesState {}
final class GetCoursesFailure extends GetCoursesState {}
final class GetCoursesProcess extends GetCoursesState {}
final class GetCoursesSuccess extends GetCoursesState {
  final List<Course> courses;

  const GetCoursesSuccess(this.courses);

  @override
  List<Object> get props => [courses];
}
