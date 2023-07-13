import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental/model/DentistModel.dart';
import 'package:idental/model/ReportModel.dart';
import 'package:idental/shared/cubits/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitalState());

  static AppCubit get(context) => BlocProvider.of(context);

  void getPendingAppointments() {
    List<Map<String, dynamic>> Appointments = [];
    final useremail = FirebaseAuth.instance.currentUser!.email;
    var collection = FirebaseFirestore.instance.collection('Appointments');
    collection
        .where('dentistemail', isEqualTo: useremail)
        .snapshots()
        .listen((querySnapshot) {
      Appointments.clear();
      for (var doc in querySnapshot.docs) {
        if (doc['status'] == 'Pending') {
          Appointments.add(doc.data());
        }
      }
      emit(GetAppointmentsSuccessState(Appointments));
    });
  }

  void declinedAppointment(String id) {
    var db = FirebaseFirestore.instance
        .collection('Appointments')
        .doc(id)
        .delete()
        .then((value) {
      getPendingAppointments();
    }).catchError((error) {
      print("failed delete");
    });
  }

  void ApprovedAppointment(String id) {
    var db = FirebaseFirestore.instance
        .collection('Appointments')
        .doc(id)
        .update({'status': 'Approved'}).then((value) {
      getPendingAppointments();
    }).catchError((error) {
      print("failed to change status");
    });
  }

  void getApprovedApps() {
    {
      List<Map<String, dynamic>> ApprovedApps = [];
      final useremail = FirebaseAuth.instance.currentUser!.email;
      var collection = FirebaseFirestore.instance.collection('Appointments');
      collection
          .where('dentistemail', isEqualTo: useremail)
          .snapshots()
          .listen((querySnapshot) {
        ApprovedApps.clear();
        for (var doc in querySnapshot.docs) {
          if (doc['status'] == 'Approved') {
            ApprovedApps.add(doc.data());
          }
        }
        emit(GetApprovedAppsSuccessState(ApprovedApps));
      });
    }
  }

  DentistModel model = DentistModel();
  void getUserData() {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    emit(GetDentistDataLoadingState());

    FirebaseFirestore.instance
        .collection('Dentists')
        .where('uId', isEqualTo: userid)
        .get()
        .then((value) {
      data = value.docs;
      if (data.isEmpty) {
        emit(GetDentistDataErrorState('User Not Found'));
      } else {
        model = DentistModel.fromdoc(data.first);
        if (model != null) {
          emit(GetDentistDataSuccessState(dentist: model));
        } else {
          emit(GetDentistDataErrorState('User Not Found'));
        }
      }
    }).catchError((error) {
      emit(GetDentistDataErrorState(error.toString()));
    });
  }

  late File profileimage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    emit(GetDentistDataLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      model = model.copyWith(profileimage: profileimage.path);
      emit(ProfileImagePickedSuccessState());
      emit(GetDentistDataSuccessState(dentist: model));
    } else {
      emit(GetDentistDataSuccessState(dentist: model));
    }
  }

  Future<void> uploadProfileImage({
    required String name,
    required String phone,
    required String clinic_name,
    required String clinic_address,
    required String socialnumber,
    required String medicalID,
  }) async {
    if (profileimage != null) {
      // upload image only if there is file
      emit(UpdateDentistDataLoadingState());
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('profileimages');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(File(profileimage.path));
        String url = await referenceImageToUpload.getDownloadURL();
        editData(
          name: name,
          phone: phone,
          clinic_name: clinic_name,
          clinic_address: clinic_address,
          socialnumber: socialnumber,
          medicalID: medicalID,
          profile_image: url,
        );
      } catch (error) {}
    } else {
      emit(UpdateDentistDataLoadingState());
      editData(
        name: name,
        phone: phone,
        clinic_name: clinic_name,
        clinic_address: clinic_address,
        socialnumber: socialnumber,
        medicalID: medicalID,
      );
    }
  }

  void editData({
    required String name,
    required String phone,
    required String clinic_name,
    required String clinic_address,
    required String socialnumber,
    required String medicalID,
    String? profile_image,
  }) {
    DentistModel dentist = DentistModel(
      name: name,
      phone: phone,
      clinicname: clinic_name,
      clinicaddress: clinic_address,
      profileimage: profile_image ?? model.profileimage,
      email: model.email,
      medicalID: medicalID,
      socialnumber: socialnumber,
      uId: model.uId,
      docid: model.docid,
    );
    FirebaseFirestore.instance
        .collection('Dentists')
        .doc(model.docid)
        .update(dentist.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateDentistDataErrorState(error.toString()));
    });
  }

  ReportModel rr = ReportModel(date: DateTime.now().toString());

  void CreateReport({
    String? dentistname,
    String? profileimage,
    String? uId,
    required String patientname,
    required String observation,
  }) {
    emit(CreateReportLoadingState());

    ReportModel report_model = ReportModel(
      dentistname: dentistname ?? model.name,
      profileimage: profileimage ?? model.profileimage,
      uId: uId ?? model.uId,
      patientname: patientname,
      docid: rr.docid,
      time: (DateFormat.Hm().format(DateTime.now())).toString(),
      date: (DateFormat.yMMMMd().format(DateTime.now())).toString(),
      observation: observation,
    );

    FirebaseFirestore.instance
        .collection('Reports')
        .add(report_model.toMap())
        .then((value) {
      emit(CreateReportSuccessState(
        report: report_model,
      ));
    }).catchError((error) {
      emit(CreateReportErrorState(error.toString()));
    });
  }

  void getReports() {
    List<Map<String, dynamic>> Allreports = [];
    final userid = FirebaseAuth.instance.currentUser!.uid;
    var collection = FirebaseFirestore.instance.collection('Reports');
    collection
        .where('uId', isEqualTo: userid)
        .snapshots()
        .listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Allreports.add(doc.data());
      }
      emit(GetReportSuccessState(Allreports));
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
