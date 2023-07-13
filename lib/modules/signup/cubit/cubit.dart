import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental/model/DentistModel.dart';
import 'package:idental/modules/signup/cubit/states.dart';
import 'package:rxdart/rxdart.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitalState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void DentistRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String socialnumber,
    required String medicalID,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(RegisterSucessState());
      DentistCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
        socialnumber: socialnumber,
        medicalID: medicalID,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void DentistCreate({
    required String uId,
    required String name,
    required String email,
    required String phone,
    required String socialnumber,
    required String medicalID,
  }) {
    DentistModel model = DentistModel(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      socialnumber: socialnumber,
      medicalID: medicalID,
    );
    FirebaseFirestore.instance
        .collection('Dentists')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateDentistSucessState());
    }).catchError((error) {
      emit(CreateDentistErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = (isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined);

    emit(ChangePasswordVisibilityState());
  }

  bool checkBoxValue = false;
  void ChangeCheckBox() {
    if (checkBoxValue == true) {
      checkBoxValue = false;
    } else {
      checkBoxValue = true;
    }
    emit(ChangeCheckBoxState());
  }

  var _phoneNumberController = BehaviorSubject<String>();
  Stream<String> get phoneNumberStream => _phoneNumberController.stream;

  updatePhone(String text) {
    if (text.length != 11) {
      _phoneNumberController.sink
          .addError("Please enter a valid phone number here");
    } else if (!RegExp(r'^(01[0,1,2,5])[0-9]{8}$').hasMatch(text)) {
      _phoneNumberController.sink
          .addError("Please enter a valid phone number here");
    } else {
      _phoneNumberController.sink.add(text);
    }
  }

  var _socialnumberController = BehaviorSubject<String>();
  Stream<String> get socialnumberStream => _socialnumberController.stream;

  updateSocialNumber(String text) {
    if (text.length != 14) {
      _socialnumberController.sink
          .addError("Please enter your 14 digit phone number here");
    } else {
      _socialnumberController.sink.add(text);
    }
  }

  var _emailController = BehaviorSubject<String>();
  Stream<String> get emailStream => _emailController.stream;

  updateEmail(String text) {
    if (text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text)) {
      _emailController.sink.addError('Please enter valid email');
    } else {
      _emailController.sink.add(text);
    }
  }

  void onNext() {
    print("Phone number = " + _phoneNumberController.value.toString());
  }
}
