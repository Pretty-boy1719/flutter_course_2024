import 'package:first_stuff/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:first_stuff/screens/home/blocs/get_courses_bloc/get_courses_bloc.dart';
import 'package:first_stuff/screens/home/views/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            const SizedBox(width: 8),
            Text(
              'Courses',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.red[50],
              ),
            ),
            const SizedBox(width: 8),
            Image.asset('assets/images/courses_0.jpg', scale: 10),

          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_shopping_cart)),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(Icons.door_back_door_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetCoursesBloc, GetCoursesState>(
  builder: (context, state) {
    if (state is GetCoursesSuccess){
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 16/9
          ),
          itemCount: state.courses.length,
          itemBuilder: (context, int i){
            return Material(
              elevation: 3,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => DetailsScreen(
                        state.courses[i]
                      ),
                    ),
                  );
                },
                child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:5, left: 4),
                        child: Image.network(
                          state.courses[i].picture,
                          scale: 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          state.courses[i].name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ) ,
                        )
                      ),

                    ],
                  ),
                  const SizedBox(width: 1),
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        height: 25,
                        width: 45,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            state.courses[i].isFree ? "Free" : "${state.courses[i].price}\$",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15
                            ),
                          )
                        )
                      ),
                      const SizedBox(height: 4),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          height: 25,
                          width: 45,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:0),
                              child: Text(
                                state.courses[i].isNew ? "New" : "Pop",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15
                                ),
                              )
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add_circle_outlined),
                              iconSize: 20.0
                          )
                      ),
                    ],
                  ),

                ],
                )
              )
            );
          },
        );
    } else if (state is GetCoursesProcess){
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text(
          "An Error occured..."
        )
      );
    }
  }
)
      )
    );
  }
}








