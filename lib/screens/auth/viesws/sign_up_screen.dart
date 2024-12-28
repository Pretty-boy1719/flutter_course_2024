import 'package:first_stuff/components/template_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool signUpRequired = false;

  IconData iconPasswordSufix = Icons.remove_red_eye;
  IconData iconPasswordPrefix = Icons.password_outlined;
  IconData iconEmail = Icons.email;
  IconData iconEye = Icons.remove_red_eye;
  IconData iconEyeEmpty = Icons.remove_red_eye_outlined;



  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if(state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if(state is SignUpFailure) {
          return;
        }
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TemplateTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email),
                    validator: (val) {
                      if(val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if(!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TemplateTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          if (obscurePassword) {
                            iconPasswordSufix = iconEye;
                          } else {
                            iconPasswordSufix = iconEyeEmpty;
                          }
                        });
                      },
                      icon: Icon(iconPasswordSufix),
                    ),
                    validator: (val) {
                      if(val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    }
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TemplateTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(Icons.person),
                    validator: (val) {
                      if(val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if(val.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    }
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              !signUpRequired
                  ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        MyUser myUser = MyUser.empty;
                        myUser.email = emailController.text;
                        myUser.name = nameController.text;

                        setState(() {
                          context.read<SignUpBloc>().add(
                              SignUpRequired(
                                  myUser,
                                  passwordController.text
                              )
                          );
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)
                        )
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                ),
              )
                  : const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}