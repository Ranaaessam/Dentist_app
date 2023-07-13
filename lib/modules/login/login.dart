import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:idental/modules/login/cubit/cubit.dart';
import 'package:idental/modules/login/cubit/states.dart';
import 'package:idental/shared/components/components.dart';
import 'package:idental/modules/signup/signup.dart';
import '../../layout/home_screen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErorrState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          } else if (state is LoginSuccessState) {
            navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: DrawClip(),
                          child: Container(
                              color: Colors.teal[200],
                              height: size.height / 2.9),
                        ),
                        ClipPath(
                          clipper: DrawClip1(),
                          child: Container(
                              color: Colors.teal, height: size.height / 2.9),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Login",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text("please sign in to continue",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          defaultFormField(
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            key: formFieldKey,
                            controller: emailController,
                            validate: (value) =>
                                EmailValidator.validate(emailController.text)
                                    ? null
                                    : "Please enter a valid email",
                            type: TextInputType.emailAddress,
                            label: 'EMAIL',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            child: defaultFormField(
                                type: TextInputType.visiblePassword,
                                controller: passwordController,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                label: 'PASSWORD',
                                prefix: Icons.lock_outline_sharp,
                                suffix: LoginCubit.get(context).suffix,
                                onSubmit: (value) {},
                                isPassword: LoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultButton(150.0, 50.0, 'LOGIN', true, () {
                            if (formKey.currentState?.validate() == null) {
                              LoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: size.height / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
                            child: Text("Don't have an account?",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.grey,
                                )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ),
                                );
                              },
                              child: Text("Sign up",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    color: Colors.teal,
                                  )))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          ;
        },
      ),
    );
  }
}

class DrawClip1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.95, 0);
    path.lineTo(size.width * 0.65, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.65 - 10, size.height * 0.3 + 10,
        size.width * 0.65, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75 + 10, size.height * 0.6 + 10,
        size.width * 0.75 + 20, size.height * 0.6 + 5);
    path.lineTo(size.width, size.height * 0.4 + 20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.83, 0);
    path.lineTo(size.width * 0.58, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.58 - 10, size.height * 0.2 + 10,
        size.width * 0.58 - 3, size.height * 0.3);
    path.lineTo(size.width * 0.67, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.67 + 10, size.height * 0.6 + 10,
        size.width * 0.67 + 20, size.height * 0.6 + 5);
    path.lineTo(size.width, size.height * 0.4 + 20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
