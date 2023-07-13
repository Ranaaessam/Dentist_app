import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/history.dart';
import 'package:idental/layout/home_screen.dart';
import '../../shared/cubits/cubits.dart';
import '../../shared/cubits/states.dart';

class NewReport extends StatelessWidget {
  final String obs;
  final _formKey = GlobalKey<FormState>();
  final _obsKey = GlobalKey<FormState>();

  NewReport({required this.obs});
  @override
  Widget build(BuildContext context) {
    var observationController = TextEditingController();
    var patientnameController = TextEditingController();
    if (obs != '') observationController.text = obs;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "New Report",
                              style: GoogleFonts.montserrat(fontSize: 22),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              child: Text("Create",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    color: Colors.teal,
                                  )),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _obsKey.currentState!.validate()) {
                                  AppCubit.get(context).CreateReport(
                                      patientname: patientnameController.text,
                                      observation: observationController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HistoryScreen(),
                                    ),
                                  );
                                }
                              }
                              // }
                              ),
                        )
                      ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).model.profileimage}'),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          '${AppCubit.get(context).model.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: patientnameController,
                      validator: (value) {
                        if (value!.isEmpty) return "please enter patient name";
                      },
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                        hintText: 'Patien Name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Form(
                      key: _obsKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "please write observation";
                        },
                        controller: observationController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          hintText: 'Please Write Your Observations.',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
