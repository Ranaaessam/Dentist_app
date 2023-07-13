import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:idental/modules/signup/cubit/cubit.dart';
import 'package:idental/modules/signup/cubit/states.dart';
import 'package:idental/shared/components/components.dart';
import '../../layout/home_screen.dart';

class Signup extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> emailFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> nameFieldKey = GlobalKey();

  final GlobalKey<FormFieldState> phoneFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> medicalFieldKey = GlobalKey();
  final GlobalKey<FormFieldState> socialFieldKey = GlobalKey();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmedPassController = TextEditingController();
  var medicalIdController = TextEditingController();
  var socialNumberController = TextEditingController();
  var phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateDentistSucessState) {
            navigateAndFinish(context, HomeScreen());
          }

          if (state is CreateDentistSucessState) {
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
                              Text("CREATE ACCOUNT",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        )
                      ],
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
                            controller: nameController,
                            onSubmit: (value) {
                              nameFieldKey.currentState!.validate();
                            },
                            key: nameFieldKey,
                            type: TextInputType.name,
                            label: 'Name',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            controller: medicalIdController,
                            validate: (value) {
                              if (medicalIdController.text.isEmpty)
                                return 'Medical ID is required';
                              else
                                null;
                            },
                            onSubmit: (value) {
                              nameFieldKey.currentState!.validate();
                            },
                            key: medicalFieldKey,
                            type: TextInputType.phone,
                            label: 'Medical Id',
                            prefix: Icons.add_card_sharp,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: BlocProvider.of<RegisterCubit>(context)
                                .socialnumberStream,
                            builder: (context, snapshot) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    defaultFormField(
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      controller: socialNumberController,
                                      onSubmit: (value) {
                                        socialFieldKey.currentState!.validate();
                                      },
                                      onChange: (value) {
                                        BlocProvider.of<RegisterCubit>(context)
                                            .updateSocialNumber(value);
                                      },
                                      key: socialFieldKey,
                                      type: TextInputType.phone,
                                      label: 'Social Number',
                                      prefix: Icons.account_box_sharp,
                                    ),
                                    snapshot.hasError
                                        ? getErrorText(
                                            snapshot.error.toString())
                                        : SizedBox(
                                            height: 0.0,
                                          )
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                              stream: BlocProvider.of<RegisterCubit>(context)
                                  .phoneNumberStream,
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      defaultFormField(
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        controller: phoneNumberController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter a Phone Number';
                                          } else if (!RegExp(
                                                  r'^01[0,1,2,5][0-9]{8}')
                                              .hasMatch(value)) {
                                            return 'Please Enter a Valid Phone Number';
                                          }
                                        },
                                        onSubmit: (value) {
                                          phoneFieldKey.currentState!
                                              .validate();
                                        },
                                        onChange: (value) {
                                          BlocProvider.of<RegisterCubit>(
                                                  context)
                                              .updatePhone(value);
                                        },
                                        key: phoneFieldKey,
                                        type: TextInputType.phone,
                                        label: 'Phone Number',
                                        prefix: Icons.phone,
                                      ),
                                      snapshot.hasError
                                          ? getErrorText(
                                              snapshot.error.toString())
                                          : SizedBox(
                                              height: 0.0,
                                            )
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                              stream: BlocProvider.of<RegisterCubit>(context)
                                  .emailStream,
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      defaultFormField(
                                          type: TextInputType.emailAddress,
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          key: emailFieldKey,
                                          controller: emailController,
                                          onSubmit: (value) {
                                            emailFieldKey.currentState!
                                                .validate();
                                          },
                                          onChange: (value) {
                                            BlocProvider.of<RegisterCubit>(
                                                    context)
                                                .updateEmail(value);
                                          },
                                          label: 'EMAIL',
                                          prefix: Icons.email_outlined),
                                      snapshot.hasError
                                          ? getErrorText(
                                              snapshot.error.toString())
                                          : SizedBox(
                                              height: 0.0,
                                            )
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 60,
                            child: defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              label: 'PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: RegisterCubit.get(context).suffix,
                              onSubmit: (value) {},
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                          ),
                          new FlutterPwValidator(
                              controller: passwordController,
                              minLength: 6,
                              uppercaseCharCount: 1,
                              specialCharCount: 1,
                              width: 400,
                              height: 90,
                              onSuccess: () {},
                              onFail: () {}),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 60,
                            child: defaultFormField(
                              type: TextInputType.visiblePassword,
                              controller: confirmedPassController,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              label: 'CONFIRM PASSWORD',
                              prefix: Icons.lock_outline_sharp,
                              suffix: RegisterCubit.get(context).suffix,
                              onSubmit: (value) {},
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                          ),
                          new FlutterPwValidator(
                              controller: confirmedPassController,
                              minLength: 6,
                              uppercaseCharCount: 1,
                              specialCharCount: 1,
                              width: 400,
                              height: 90,
                              onSuccess: () {},
                              onFail: () {}),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: RegisterCubit.get(context).checkBoxValue,
                                onChanged: (bool? value) {
                                  RegisterCubit.get(context).ChangeCheckBox();
                                },
                                activeColor: Color(0xff54ccf5),
                              ),
                              Text(
                                'I agree to the terms and conditions',
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => defaultButton(
                                      150.0, 50.0, 'SIGNUP', true, () {
                                    if (formKey.currentState?.validate() ==
                                        null) {
                                      RegisterCubit.get(context)
                                          .DentistRegister(
                                        name: nameController.text.toLowerCase(),
                                        email: emailController.text,
                                        password: passwordController.text,
                                        medicalID: medicalIdController.text,
                                        phone: phoneNumberController.text,
                                        socialnumber:
                                            socialNumberController.text,
                                      );
                                    }
                                  })),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
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
