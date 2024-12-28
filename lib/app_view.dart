import 'package:first_stuff/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:first_stuff/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:first_stuff/screens/auth/viesws/welcome_screen.dart';
import 'package:first_stuff/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Course Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.pinkAccent.shade700,
            onBackground: Colors.black,
            primary: Colors.blue,
            onPrimary: Colors.white
          )
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if(state.status == AuthenticationStatus.authenticated){
              return BlocProvider(
                 create: (context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository
                  ),
                  child: const HomeScreen(),
              );
           } else{
            return const WelcomeScreen();
          }
        }),
      )
    );
  }
}
